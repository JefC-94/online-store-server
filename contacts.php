<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, X-Authorization, X-Requested-With");

function msg($success,$status,$message,$extra = []){
    return array_merge([
        'success' => $success,
        'status' => $status,
        'message' => $message
    ],$extra);
}

$returnData = msg(1,201,'Here so far!');

//echo json_encode($returnData);

// INCLUDING DATABASE AND MAKING OBJECT
require __DIR__.'/classes/Database.php';
$db_connection = new Database();
$conn = $db_connection->dbConnection();

$user_id = +($_GET['user_id']);

$returnData = msg(1,201, $user_id);

//echo json_encode($returnData);

try{
    // get data from the database
    $get_contacts = "
        SELECT users.username, users.id, photo_url, created_at, updated_at FROM users
        WHERE users.id NOT IN (
            SELECT contact.user_2 FROM users 
            INNER JOIN contact ON contact.user_1 = users.id
            WHERE contact.user_1 = :id OR contact.user_2 = :id
        )
        AND users.id NOT IN (
            SELECT contact.user_1 FROM users 
            INNER JOIN contact ON contact.user_1 = users.id
            WHERE contact.user_1 = :id OR contact.user_2 = :id
            )
        AND users.id <> :id
    ";
    $query_stmt = $conn->prepare($get_contacts);
    $query_stmt->bindValue(':id', $user_id, PDO::PARAM_INT);
    $query_stmt->execute();

    if($query_stmt->rowCount()):

        $rows = $query_stmt->fetchAll(PDO::FETCH_ASSOC);

        $returnData = [
            'success' => 1,
            'status' => 200,
            'records' => $rows
        ];

    else: 

        $returnData = msg(0,404,"No results");

    endif;

} catch(PDOException $e){

    $returnData = msg(0,500,$e->getMessage());

}

echo json_encode($returnData);

/* INNER JOIN contact ON contact.id = contact.user_1
INNER JOIN contact ON contact.id = contact.user_2
WHERE contact.user_1 = :id OR contact.user_2 = :id */

?>

