<?php
class Database{
        
    public function dbConnection(){

        if($_SERVER['SERVER_NAME'] === 'chatster.be'){
            $db_host = 'ID348579_messagingapp.db.webhosting.be';
            $db_name = 'ID348579_messagingapp';
            $db_username = 'ID348579_messagingapp';
            $db_password = 'pur3r4nd0mn3ss';
        } else {
            $db_host = 'localhost';
            $db_name = 'shopping_app';
            $db_username = 'root';
            $db_password = 'rootpass';
        }
        
        try{
            $conn = new PDO('mysql:host='.$db_host.';dbname='.$db_name,$db_username,$db_password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $conn;
        }
        catch(PDOException $e){
            echo "Connection error ".$e->getMessage(); 
            exit;
        }
    }
}
