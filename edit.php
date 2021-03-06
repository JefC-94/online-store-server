<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: PUT");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, X-Authorization, X-Requested-With");

function msg($success,$status,$message,$extra = []){
    return array_merge([
        'success' => $success,
        'status' => $status,
        'message' => $message
    ],$extra);
}

require __DIR__.'/classes/Database.php';
require __DIR__.'/classes/JwtHandler.php';

$db_connection = new Database();
$conn = $db_connection->dbConnection();

$data = json_decode(file_get_contents("php://input"));
$returnData = [];

// IF REQUEST METHOD IS NOT EQUAL TO PUT
if($_SERVER["REQUEST_METHOD"] != "PUT"):
    $returnData = msg(0,404,'Page Not Found!');

// CHECKING EMPTY FIELDS
elseif(!isset($data->username) 
    || empty(trim($data->username))
    ):

    $returnData = msg(0,422,json_encode(array('type' => 'username', 'message' => 'Please fill in your username!')));

elseif(!isset($data->oldPassword)
    || empty(trim($data->oldPassword))
    ):

    $returnData = msg(0,422,json_encode(array('type' => 'old-password', 'message' => 'Please fill in your current password!')));


// IF THERE ARE NO EMPTY FIELDS THEN-
else:
    $id = $data->id;
    $username = trim($data->username);
    $oldPassword = trim($data->oldPassword);
    $newPassword = trim($data->newPassword);

    // IF THERE IS A NEW PASSWORD AND IT IS LESS THAN 8 THEN SHOW THE ERROR
    if(!empty(trim($data->newPassword)) && strlen($newPassword) < 8):
        $returnData = msg(0,422,json_encode(array('type' => 'new-password', 'message' => 'Your new password must be at least 8 characters long')));
        
    // THE USER IS ABLE TO PERFORM THE EDIT ACTION
    else:
        try{
            
            $fetch_user_by_id = "SELECT * FROM `users` WHERE `id`=:id";
            $query_stmt = $conn->prepare($fetch_user_by_id);
            $query_stmt->bindValue(':id', $id, PDO::PARAM_INT);
            $query_stmt->execute();

            // IF THE USER IS FOUNDED BY EMAIL
            if($query_stmt->rowCount()):
                $row = $query_stmt->fetch(PDO::FETCH_ASSOC);
                $check_password = password_verify($oldPassword, $row['password']);

                // VERIFYING THE PASSWORD (IS CORRECT OR NOT?)
                // IF PASSWORD IS CORRECT THEN SEND THE LOGIN TOKEN
                if($check_password):
                  
                    // CHECK IF NEW PASSWORD FIELD IS EMPTY
                    if(empty(trim($data->newPassword))):

                        $alter_query = "UPDATE `users` SET `username`=:username, `updated_at`=:updatedat WHERE `id`=:id";
                        $alter_stmt = $conn->prepare($alter_query);

                        $alter_stmt->bindValue(':username', htmlspecialchars(strip_tags($username)), PDO::PARAM_STR);
                        $alter_stmt->bindValue(':id', $id, PDO::PARAM_INT);
                        $alter_stmt->bindValue(':updatedat', time(), PDO::PARAM_INT);

                        $alter_stmt->execute();

                        $returnData = msg(1,201,'You have succesfully updated your profile');
                        
                    else:

                        //CHANGE PASSWORD AS WELL;
                        $alter_query = "UPDATE `users` SET `username`=:username, `password`=:password, `updated_at`=:updatedat WHERE `id`=:id";
                        $alter_stmt = $conn->prepare($alter_query);

                        $alter_stmt->bindValue(':username', htmlspecialchars(strip_tags($username)), PDO::PARAM_STR);
                        $alter_stmt->bindValue(':id', $id, PDO::PARAM_INT);
                        $alter_stmt->bindValue(':password', password_hash($newPassword, PASSWORD_DEFAULT), PDO::PARAM_STR);
                        $alter_stmt->bindValue(':updatedat', time(), PDO::PARAM_INT);

                        $alter_stmt->execute();

                        $returnData = msg(1,201,'You have succesfully changed your password and updated your profile');

                    endif;

                // IF INVALID PASSWORD
                else:
                    $returnData = msg(0,422,json_encode(array('type' => 'old-password', 'message' => 'Your current password is incorrect!')));
                endif;

            // IF THE USER IS NOT FOUNDED BY EMAIL THEN SHOW THE FOLLOWING ERROR
            else:
                $returnData = msg(0,422,json_encode(array('type' => 'username', 'message' => 'Invalid user!')));
            endif;
        }
        catch(PDOException $e){
            $returnData = msg(0,500,$e->getMessage());
        }

    endif;

endif;

echo json_encode($returnData);
