<?php

unset($CFG);  // Ignore this line
global $CFG;  // This is necessary here for PHPUnit execution
$CFG = new stdClass();

////////////////////////////////
// Database setup
////////////////////////////////
$CFG->dbtype    = '##DB_DRIVER##';
$CFG->dblibrary = 'native';
$CFG->dbhost    = '##DB_HOST##';
$CFG->dbname    = '##DB_NAME##';
$CFG->dbuser    = '##DB_USER##';
$CFG->dbpass    = '##DB_PASS##';
$CFG->prefix    = '##DB_PREFIX##';
$CFG->dboptions = array (
    'dbpersist' => 0,
    'dbport' => ##DB_PORT##,
    'dbsocket' => '',
);

////////////////////////////////
// Server information
////////////////////////////////
$CFG->wwwroot   = '##WWW_ROOT##'; // System URL
//$CFG->siteadmins= '2,...';      // Other admins

////////////////////////////////
// Storage information
////////////////////////////////
$CFG->dataroot  = '##MOODLE_DATA##';  // Moodledata folder
$CFG->directorypermissions = 0777;    // Moodledata files permission

////////////////////////////////
// Overwrite defaults
////////////////////////////////
//$CFG->theme                    = 'boost';  // Foce theme for the instance
//$CFG->alternateloginurl        = '';       // Reset login URL
//$CFG->disablelogintoken        = true;     // Do not check token on login. Risky SSO
$CFG->disableupdatenotifications = true;     // Ignore update warnings
<?php

unset($CFG);  // Ignore this line
global $CFG;  // This is necessary here for PHPUnit execution
$CFG = new stdClass();

////////////////////////////////
// Database setup
////////////////////////////////
$CFG->dbtype    = '##DB_DRIVER##';
$CFG->dblibrary = 'native';
$CFG->dbhost    = '##DB_HOST##';
$CFG->dbname    = '##DB_NAME##';
$CFG->dbuser    = '##DB_USER##';
$CFG->dbpass    = '##DB_PASS##';
$CFG->prefix    = '##DB_PREFIX##';
$CFG->dboptions = array (
    'dbpersist' => 0,
    'dbport' => ##DB_PORT##,
    'dbsocket' => '',
);

////////////////////////////////
// Server information
////////////////////////////////
$CFG->wwwroot   = '##WWW_ROOT##'; // System URL
//$CFG->siteadmins= '2,...';      // Other admins

////////////////////////////////
// Storage information
////////////////////////////////
$CFG->dataroot  = '##MOODLE_DATA##';  // Moodledata folder
$CFG->directorypermissions = 0777;    // Moodledata files permission

////////////////////////////////
// Overwrite defaults
////////////////////////////////

//$CFG->theme                    = 'boost';  // Foce theme for the instance
//$CFG->alternateloginurl        = '';       // Reset login URL
//$CFG->disablelogintoken        = true;     // Do not check token on login. Risky SSO
$CFG->disableupdatenotifications = true;     // Ignore update warnings

