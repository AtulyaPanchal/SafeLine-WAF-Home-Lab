<?php
// DVWA database configuration template
// Copy this over /var/www/html/DVWA/config/config.inc.php
// (after `cp config.inc.php.dist config.inc.php`)
//
// Replace the placeholder password before using in your lab.

$_DVWA = array();
$_DVWA[ 'db_server' ]   = '127.0.0.1';
$_DVWA[ 'db_database' ] = 'dvwa';
$_DVWA[ 'db_user' ]     = 'dvwa_user';
$_DVWA[ 'db_password' ] = 'CHANGE_ME';
$_DVWA[ 'db_port' ]     = '3306';

// reCAPTCHA keys (optional, leave blank for lab use)
$_DVWA[ 'recaptcha_public_key' ]  = '';
$_DVWA[ 'recaptcha_private_key' ] = '';

// Default security level on install
$_DVWA[ 'default_security_level' ] = 'impossible';

// Whether to show PHP errors / verbose output (keep off for realism)
$_DVWA[ 'show_php_info' ] = 'false';
