<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: *");
include "./conn.php"; // Include your database connection file

// Handle different HTTP methods
$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        // Retrieve store names
        getStoreNames();
        break;
    case 'POST':
        // Add a new store name
        addStoreName();
        break;
    default:
        // Unsupported method
        http_response_code(405); // Method Not Allowed
        echo json_encode(array('message' => 'Unsupported HTTP method'));
        break;
}
    
function getStoreNames() {
    global $conn;

    $sql = "SELECT * FROM StoreNames join storetypes USING(`TypeID`)";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $storeNames = array();
        while ($row = $result->fetch_assoc()) {
            $storeNames[] = $row;
        }
        echo json_encode($storeNames);
    } else {
        echo json_encode(array('message' => 'No store names found.'));
    }
}

function addStoreName() {
    global $conn;

    // Assuming JSON data is sent in the request body
    $data = json_decode(file_get_contents('php://input'), true);

    if (isset($data['StoreName']) && isset($data['TypeID'])) {
        $storeName = $data['StoreName'];
        $typeID = $data['TypeID'];

        $sql = "SELECT MAX(StoreID) AS MAX_StoreID FROM StoreNames";
        $objQuery = mysqli_query($conn, $sql) or die(mysqli_error($conn));

        while ($row1 = mysqli_fetch_array($objQuery)) {
            if ($row1["MAX_StoreID"] != "") {
                $no = $row1["MAX_StoreID"] + 1;
            }
        }

        $newno = "0000" . (string) $no;
        $newno = substr($newno, -5);
        $newStoreID = $newno;

        // Insert the new store name
        $insertSql = "INSERT INTO StoreNames (StoreID, StoreName, TypeID) VALUES ('$newStoreID', '$storeName', '$typeID')";
        if ($conn->query($insertSql) === TRUE) {
            // Explicitly set HTTP status code to 200
            http_response_code(200);
            echo json_encode(array('message' => 'Store name added successfully.'));
        } else {
            // Explicitly set HTTP status code to 500 for server error
            http_response_code(500);
            echo json_encode(array('message' => 'Error adding store name: ' . $conn->error));
        }
    } else {
        // Explicitly set HTTP status code to 400 for bad request
        http_response_code(400);
        echo json_encode(array('message' => 'Invalid data. StoreName and TypeID are required.'));
    }
}
?>
