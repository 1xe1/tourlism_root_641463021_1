<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: *");
include "./conn.php"; // Include your database connection file

// Handle different HTTP methods
$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        // Retrieve bus schedules
        getBusSchedules();
        break;
    case 'POST':
        // Add a new bus schedule
        addBusSchedule();
        break;
    default:
        // Unsupported method
        http_response_code(405); // Method Not Allowed
        echo json_encode(array('message' => 'Unsupported HTTP method'));
        break;
}

function getBusSchedules() {
    global $conn;

    $sql = "SELECT BusSchedule.ScheduleID, BusSchedule.Time, BusSchedule.PlaceID, touristplaces.PlaceName FROM BusSchedule JOIN touristplaces USING (PlaceID)";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $busSchedules = array();
        while ($row = $result->fetch_assoc()) {
            $busSchedules[] = $row;
        }
        echo json_encode($busSchedules);
    } else {
        echo json_encode(array('message' => 'No bus schedules found.'));
    }
}

function addBusSchedule() {
    global $conn;

    // Assuming JSON data is sent in the request body
    $data = json_decode(file_get_contents('php://input'), true);

    if (isset($data['Time']) && isset($data['PlaceID'])) {
        $time = $data['Time'];
        $placeID = $data['PlaceID'];

        // Insert the new bus schedule
        $insertSql = "INSERT INTO BusSchedule (Time, PlaceID) VALUES ('$time', '$placeID')";
        if ($conn->query($insertSql) === TRUE) {
            // Explicitly set HTTP status code to 200
            http_response_code(200);
            echo json_encode(array('message' => 'Bus schedule added successfully.'));
        } else {
            // Explicitly set HTTP status code to 500 for server error
            http_response_code(500);
            echo json_encode(array('message' => 'Error adding bus schedule: ' . $conn->error));
        }
    } else {
        // Explicitly set HTTP status code to 400 for bad request
        http_response_code(400);
        echo json_encode(array('message' => 'Invalid data. Time and PlaceID are required.'));
    }
}
?>
