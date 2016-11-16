<?php

class Message {
    private $id=NULL;
    private $timestamp;
    private $email='';
    private $texte='';
    private $url='';

    public function __construct() {
            $this->timestamp = time();
    }

    public function getDate($format = "%A %d %B %Y %T") {
        return strftime($format,(int)$this->timestamp);
    }

    public function getDateSql() {
        return $this->getDate("%Y-%m-%d %H:%M:%S");
    }

    public function setDate($d) {
        $this->timestamp= (int) $d;
    }

    public function getEmail() {
        return $this->email;
    }

    public function setEmail($e) {
        if (filter_var($e, FILTER_VALIDATE_EMAIL)) {
            $this->email=$e;
        } else {
            throw new \Exception("Email non valide");
        }
    }

    public function getTexte() {
        return $this->texte;
    }

    public function setTexte($t) {
        $this->texte=filter_var($t,FILTER_SANITIZE_STRING);
    }

    public function getId() {
        return $this->id;
    }

    public function setId($id) {
        $this->id = (int) $id;
    }

    public function getUrl() {
        return $this->url;
    }

    public function setUrl($u) {
        if (filter_var($u, FILTER_VALIDATE_URL)) {
            $this->url=$u;
        } else {
            throw new \Exception("URL non valide");
        }
    }
}