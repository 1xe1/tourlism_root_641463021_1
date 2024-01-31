<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: *");
include "./conn.php"; // Include your database connection file

// Handle different HTTP methods
$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        // Retrieve store types
        getStoreTypes();
        break;
    case 'POST':
        // Add a new store type
        addStoreType();
        break;
    default:
        // Unsupported method
        http_response_code(405); // Method Not Allowed
        echo json_encode(array('message' => 'Unsupported HTTP method'));
        break;
}

function getStoreTypes() {
    global $conn;

    $sql = "SELECT * FROM StoreTypes";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $storeTypes = array();
        while ($row = $result->fetch_assoc()) {
            $storeTypes[] = $row;
        }
        echo json_encode($storeTypes);
    } else {
        echo json_encode(array('message' => 'No store types found.'));
    }
}

function addStoreType() {
    global $conn;

    // Assuming JSON data is sent in the request body
    $data = json_decode(file_get_contents('php://input'), true);

    if (isset($data['TypeName'])) {
        $typeName = $data['TypeName'];

        $sql = "SELECT MAX(TypeID) AS MAX_TypeID FROM StoreTypes";
        $objQuery = mysqli_query($conn, $sql) or die(mysqli_error($conn));

        while ($row1 = mysqli_fetch_array($objQuery)) {
            if ($row1["MAX_TypeID"] != "") {
                $no = $row1["MAX_TypeID"] + 1;
            }
        }

        $newno = "0000" . (string) $no;
        $newno = substr($newno, -5);
        $newTypeID = $newno;

        // Insert the new store type
        $insertSql = "INSERT INTO StoreTypes (TypeID, TypeName) VALUES ('$newTypeID', '$typeName')";
        if ($conn->query($insertSql) === TRUE) {
            // Explicitly set HTTP status code to 200
            http_response_code(200);
            echo json_encode(array('message' => 'Store type added successfully.'));
        } else {
            // Explicitly set HTTP status code to 500 for server error
            http_response_code(500);
            echo json_encode(array('message' => 'Error adding store type: ' . $conn->error));
        }
    } else {
        // Explicitly set HTTP status code to 400 for bad request
        http_response_code(400);
        echo json_encode(array('message' => 'Invalid data. TypeName is required.'));
    }
}
?>
