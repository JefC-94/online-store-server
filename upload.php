<?php 

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET, POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require __DIR__.'/classes/Database.php';
require __DIR__.'/classes/JwtHandler.php';

$db_connection = new Database();
$conn = $db_connection->dbConnection();

function msg($success,$status,$message,$extra = []){
    return array_merge([
        'success' => $success,
        'status' => $status,
        'message' => $message
    ],$extra);
}

//$returnData = msg(1,201,'Here so far!');

$file = $_FILES["fileToUpload"];
$id = $_POST['id'];

$returnData = msg(1, 201, $id);

try {
   
    // Undefined | Multiple Files | $_FILES Corruption Attack
    // If this request falls under any of them, treat it invalid.
    if (
        !isset($_FILES['fileToUpload']['error']) ||
        is_array($_FILES['fileToUpload']['error'])
    ) {
        throw new RuntimeException('Invalid parameters.');
    }

    // Check $_FILES['fileToUpload']['error'] value.
    switch ($_FILES['fileToUpload']['error']) {
        case UPLOAD_ERR_OK:
            break;
        case UPLOAD_ERR_NO_FILE:
            throw new RuntimeException('No file sent.');
        case UPLOAD_ERR_INI_SIZE:
        case UPLOAD_ERR_FORM_SIZE:
            throw new RuntimeException('Exceeded filesize limit.');
        default:
            throw new RuntimeException('Unknown errors.');
    }

    // You should also check filesize here.
    if ($_FILES['fileToUpload']['size'] > 1000000) {
        throw new RuntimeException('Exceeded filesize limit.');
    }

    // DO NOT TRUST $_FILES['fileToUpload']['mime'] VALUE !!
    // Check MIME Type by yourself.
    $finfo = new finfo(FILEINFO_MIME_TYPE);
    if (false === $ext = array_search(
        $finfo->file($_FILES['fileToUpload']['tmp_name']),
        array(
            'jpg' => 'image/jpeg',
            'png' => 'image/png',
            'gif' => 'image/gif',
        ),
        true
    )) {
        throw new RuntimeException('Invalid file format.');
    }

    // You should name it uniquely.
    // DO NOT USE $_FILES['fileToUpload']['name'] WITHOUT ANY VALIDATION !!
    // On this example, obtain safe unique name from its binary data.

    $filename = sprintf('./uploads/%s.%s',
    sha1_file($_FILES['fileToUpload']['tmp_name']),
    $ext
    );

    if (!move_uploaded_file(
        $_FILES['fileToUpload']['tmp_name'],
        $filename
    )) {
        throw new RuntimeException('Failed to move uploaded file.');
    }

    //Save to db for this user!!
    
    $alter_query = "UPDATE `users` SET `photo_url`=:photourl WHERE `id`=:id";
    $alter_stmt = $conn->prepare($alter_query);

    $alter_stmt->bindValue(':photourl', $filename, PDO::PARAM_STR);
    $alter_stmt->bindValue(':id', $id, PDO::PARAM_INT);
    
    $alter_stmt->execute();

    $returnData = msg(1,201,'You have successfuly changed your profile picture.');

} catch (RuntimeException $e) {

    $returnData = msg(0,500,$e->getMessage());

}

echo json_encode($returnData);

?>