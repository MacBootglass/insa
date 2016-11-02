<?php
  session_start();
  if (isset($SESSION_['userID'])) {
    unset($SESSION_['userID']);
  }
  session_destroy();
?>
