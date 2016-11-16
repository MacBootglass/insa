<?php

class MessageDb extends db {
	public static function CreateTable () {
        self::Query("CREATE TABLE IF NOT EXISTS messages (
        message_id INTEGER PRIMARY KEY,
        message_date TEXT NOT NULL,
        message_email TEXT NOT NULL,
        message_texte TEXT NOT NULL,
        message_url TEXT NOT NULL
        )");
    }

    public static function LoadSample() {
        $allm = array(
            array('email'=>'bob@leponge.fr','texte'=>"Symfony, l'un des framework les plus utilisé",'url'=>"http://symfony.com/"),
            array('email'=>'bob@leponge.fr','texte'=>"L'un des premiers frameworks PHP, inspiré de RAIL",'url'=>"http://cakephp.org/"),
            array('email'=>'bob@leponge.fr','texte'=>"Jelix, un framework robuste",'url'=>"http://jelix.org/fr/"),
            array('email'=>'bob@leponge.fr','texte'=>"FuelPHP un framework qui monte en ce moment",'url'=>"http://www.fuelphp.com/")
        );
        foreach ($allm as $m) {
            $message = new Message();
            $message->setEmail($m['email']);
            $message->setTexte($m['texte']);
            $message->setUrl($m['url']);
            self::Create($message);
        }
    }

    public static function Create($message) {
        self::Prepare("INSERT INTO messages (message_date, message_email, message_texte, message_url) VALUES ( :date, :email, :texte, :url )");
        self::Execute(array(':date'=>$message->getDateSql(),
                            ':email'=>$message->getEmail(),
                            ':texte'=>$message->getTexte(),
                            ':url'=>$message->getUrl()
                            ));
    }

    public static function Read($id) {
        self::Prepare("SELECT * FROM messages WHERE message_id = :id");
        $liste_messages = self::Execute(array(':id'=>(int)$id ));
        $row = $liste_messages[0];
        $message = new Message();
        $message->setId($row['message_id']);
        $message->setDate(strtotime($row['message_date']));
        $message->setEmail($row['message_email']);
        $message->setTexte($row['message_texte']);
        $message->setUrl($row['message_url']);
        return $message;
    }

    public static function Update($message) {
        self::Prepare("UPDATE messages SET message_date = :date, message_email = :email, message_texte = :texte, message_url = :url WHERE message_id = :id");
        self::Execute(array(':date'=>$message->getDateSql(),
                            ':email'=>$message->getEmail(),
                            ':texte'=>$message->getTexte(),
                            ':url'=>$message->getUrl(),
                            ':id'=>$message->getId()
                            ));
    }

    public static function Delete($id) {
        self::Prepare("DELETE FROM messages WHERE message_id = :id");
        self::Execute(array(':id'=>$id ));
    }

    public static function ListMessage() {
      $messages = array();
      $liste_messages = self::Query("SELECT * FROM messages ORDER BY message_date DESC");
      foreach($liste_messages as $row) {
        $message = new Message();
        $message->setId($row['message_id']);
        $message->setDate(strtotime($row['message_date']));
        $message->setEmail($row['message_email']);
        $message->setTexte($row['message_texte']);
        $message->setUrl($row['message_url']);
        $messages[] = $message;
      }
      return $messages;
    }

}
