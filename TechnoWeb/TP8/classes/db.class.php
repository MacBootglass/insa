<?php
class db {
	private static $conString;
	private static $conActive = false;
    private static $db;
    private static $preparequery = false;
	public static function Connect ($constring = false) {
		if ($constring) {
			db::$conString = $constring;
		}
	    try {
	      self::$db = new \PDO(db::$conString);
          self::$db->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
	    } catch(Exception $e) {
            self::$conActive = false;
	      	throw $e;
	    }
        self::$conActive = true;
    }

    public static function OnlyConActive () {
        if (!self::$conActive) {
            throw new \Exception("DB non connectée");
        }
    }

    public static function Query ($sql) {
        self::OnlyConActive();
        try {
            return self::$db->query($sql);
        } catch(Exception $e) {
            throw $e;
        }
    }
    public static function Prepare ($sql) {
        self::OnlyConActive();
        try {
            self::$preparequery = self::$db->prepare($sql);
        } catch(Exception $e) {
            throw $e;
        }
    }
    public static function Execute ($params) {
        self::OnlyConActive();
        if (!self::$preparequery) {
            throw new \Exception("On ne peut pas executer avant d'avoir préparé sa query");
        }
        try {
            self::$preparequery->execute($params);
            return self::$preparequery->fetchAll();
        } catch(Exception $e) {
            throw $e;
        }
        self::$preparequery = false;
    }

}