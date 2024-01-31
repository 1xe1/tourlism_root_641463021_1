<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: *");
include "./conn.php"; // Include your database connection file

// Handle different HTTP methods
$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        // Retrieve tourist places
        getTouristPlaces();
        break;
    case 'POST':
        // Add a new tourist place
        addTouristPlace();
        break;
    default:
        // Unsupported method
        http_response_code(405); // Method Not Allowed
        echo json_encode(array('message' => 'Unsupported HTTP method'));
        break;
}

function getTouristPlaces() {
    global $conn;

    $sql = "SELECT * FROM TouristPlaces";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $touristPlaces = array();
        while ($row = $result->fetch_assoc()) {
            $touristPlaces[] = $row;
        }
        echo json_encode($touristPlaces);
    } else {
        echo json_encode(array('message' => 'No tourist places found.'));
    }
}

function addTouristPlace() {
    global $conn;

    // Assuming JSON data is sent in the request body
    $data = json_decode(file_get_contents('php://input'), true);

    if (isset($data['PlaceName']) && isset($data['Description']) && isset($data['Latitude']) && isset($data['Longitude'])) {
        $placeName = $data['PlaceName'];
        $description = $data['Description'];
        $latitude = $data['Latitude'];
        $longitude = $data['Longitude'];

        $sql = "SELECT MAX(placeID) AS MAX_placeID FROM TouristPlaces ";
        $objQuery = mysqli_query($conn, $sql) or die(mysqli_error($conn));

        while ($row1 = mysqli_fetch_array($objQuery)) {
            if ($row1["MAX_placeID"] != "") {
                $no = $row1["MAX_placeID"] + 1;
            }
        }

        $newno = "0000" . (string) $no;
        $newno = substr($newno, -5);
        $newplaceID = $newno;

        $sql = "INSERT INTO TouristPlaces (PlaceID, PlaceName, Description, Latitude, Longitude) VALUES ('$newplaceID','$placeName', '$description', $latitude, $longitude)";

        if ($conn->query($sql) === TRUE) {
            // Explicitly set HTTP status code to 200
            http_response_code(200);
            echo json_encode(array('message' => 'Tourist place added successfully.'));
        } else {
            // Explicitly set HTTP status code to 500 for server error
            http_response_code(500);
            echo json_encode(array('message' => 'Error adding tourist place: ' . $conn->error));
        }
    } else {
        // Explicitly set HTTP status code to 400 for bad request
        http_response_code(400);
        echo json_encode(array('message' => 'Invalid data. PlaceName, Description, Latitude, and Longitude are required.'));
    }
}

?>
