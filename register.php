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

    $returnData = msg(0,422,json_encode(array('type' => 'username', 'message' => 'Vul een gebruikersnaam in')));

elseif(!isset($data->email) 
    || empty(trim($data->email))
    ):

    $returnData = msg(0,422,json_encode(array('type' => 'email', 'message' => 'Vul een e-mailadres in')));

elseif(!isset($data->password)
    || empty(trim($data->password))
    ):

    $returnData = msg(0,422,json_encode(array('type' => 'password', 'message' => 'Vul een wachtwoord in')));

// IF THERE ARE NO EMPTY FIELDS THEN-
else:
    
    $username = trim($data->username);
    $email = trim($data->email);
    $password = trim($data->password);

     

    if(!filter_var($email, FILTER_VALIDATE_EMAIL)):
        $returnData = msg(0,422, json_encode(array('type' => 'email', 'message' => 'Sorry, dit is geen geldig e-mailadres')));
    
    elseif(strlen($password) < 8):
        $returnData = msg(0,422, json_encode(array('type' => 'password', 'message' => 'Je wachtwoord moet minstens 8 tekens lang zijn')));

    elseif(strlen($username) < 3):
        $returnData = msg(0,422, json_encode(array('type' => 'username', 'message' => 'Je gebruikersnaam moet minstens 3 tekens lang zijn')));

    else:
        try{

            $check_email = "SELECT `email` FROM `users` WHERE `email`=:email";
            $check_email_stmt = $conn->prepare($check_email);
            $check_email_stmt->bindValue(':email', $email,PDO::PARAM_STR);
            $check_email_stmt->execute();

            if($check_email_stmt->rowCount()):
                $returnData = msg(0,422, json_encode(array('type' => 'email', 'message' => "Dit e-mailadres staat al geregistreerd")));
            
            else:
                $insert_query = "INSERT INTO `users`(`username`,`email`,`password`,`created_at`) VALUES(:username,:email,:password,:createdat)";

                $insert_stmt = $conn->prepare($insert_query);

                // DATA BINDING
                $insert_stmt->bindValue(':username', htmlspecialchars(strip_tags($username)),PDO::PARAM_STR);
                $insert_stmt->bindValue(':email', $email,PDO::PARAM_STR);
                $insert_stmt->bindValue(':password', password_hash($password, PASSWORD_DEFAULT),PDO::PARAM_STR);
                $insert_stmt->bindValue(':createdat', time(), PDO::PARAM_INT);

                $insert_stmt->execute();

                $last_id = $conn->lastInsertId();

                $returnData = msg($last_id,201,'Je bent registreerd!');

            endif;

        }
        catch(PDOException $e){
            $returnData = msg(0,500,$e->getMessage());
        }
    endif;
    
endif;

echo json_encode($returnData);