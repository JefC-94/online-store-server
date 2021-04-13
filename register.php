<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, X-Authorization, X-Requested-With");

function msg($success,$status,$message,$extra = []){
    return array_merge([
        'success' => $success,
        'status' => $status,
        'message' => $message
    ],$extra);
}

// INCLUDING DATABASE AND MAKING OBJECT
require __DIR__.'/classes/Database.php';
$db_connection = new Database();
$conn = $db_connection->dbConnection();

// GET DATA FORM REQUEST
$data = json_decode(file_get_contents("php://input"));
$returnData = [];

// IF REQUEST METHOD IS NOT POST
if($_SERVER["REQUEST_METHOD"] != "POST"):
    $returnData = msg(0,404,'Page Not Found!');

// CHECKING EMPTY FIELDS
elseif(!isset($data->username) 
    || empty(trim($data->username))
    ):

    $returnData = msg(0,422,json_encode(array('type' => 'username', 'message' => 'Please fill in a username.')));

elseif(!isset($data->email) 
    || empty(trim($data->email))
    ):

    $returnData = msg(0,422,json_encode(array('type' => 'email', 'message' => 'Please fill in an e-mail address.')));

elseif(!isset($data->password)
    || empty(trim($data->password))
    ):

    $returnData = msg(0,422,json_encode(array('type' => 'password', 'message' => 'Please fill in a password.')));

// IF THERE ARE NO EMPTY FIELDS THEN-
else:
    
    $username = trim($data->username);
    $email = trim($data->email);
    $password = trim($data->password);

     

    if(!filter_var($email, FILTER_VALIDATE_EMAIL)):
        $returnData = msg(0,422, json_encode(array('type' => 'email', 'message' => 'This is not a valid e-mail address.')));
    
    elseif(strlen($password) < 8):
        $returnData = msg(0,422, json_encode(array('type' => 'password', 'message' => 'Your password must be at least 8 characters long.')));

    elseif(strlen($username) < 3):
        $returnData = msg(0,422, json_encode(array('type' => 'username', 'message' => 'Your username must be at least 3 characters long.')));

    else:
        try{

            $check_email = "SELECT `email` FROM `users` WHERE `email`=:email";
            $check_email_stmt = $conn->prepare($check_email);
            $check_email_stmt->bindValue(':email', $email,PDO::PARAM_STR);
            $check_email_stmt->execute();

            if($check_email_stmt->rowCount()):
                $returnData = msg(0,422, json_encode(array('type' => 'email', 'message' => "We're sorry, this e-mail already in use.")));
            
            else:
                $insert_query = "INSERT INTO `users`(`username`,`email`,`password`,`created_at`) VALUES(:username,:email,:password,:createdat)";

                $insert_stmt = $conn->prepare($insert_query);

                // DATA BINDING
                $insert_stmt->bindValue(':username', htmlspecialchars(strip_tags($username)),PDO::PARAM_STR);
                $insert_stmt->bindValue(':email', $email,PDO::PARAM_STR);
                $insert_stmt->bindValue(':password', password_hash($password, PASSWORD_DEFAULT),PDO::PARAM_STR);
                $insert_stmt->bindValue(':createdat', time(), PDO::PARAM_INT);

                $insert_stmt->execute();

                $returnData = msg(1,201,'You have successfully registered.');

            endif;

        }
        catch(PDOException $e){
            $returnData = msg(0,500,$e->getMessage());
        }
    endif;
    
endif;

echo json_encode($returnData);