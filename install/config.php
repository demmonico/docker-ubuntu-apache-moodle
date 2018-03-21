<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'mariadb';
$CFG->dblibrary = 'native';
$CFG->dbhost    = '{{ DMC_APP_MOODLE_DB_HOST }}';
$CFG->dbname    = '{{ DMC_APP_MOODLE_DB_NAME }}';
$CFG->dbuser    = 'root';
$CFG->dbpass    = '';
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
    'dbpersist' => 0,
    'dbport' => '',
    'dbsocket' => '',
    'dbcollation' => 'utf8mb4_general_ci',
);

$CFG->wwwroot   = 'http://{{ DMC_APP_MOODLE_HTTP_HOST }}';
$CFG->dataroot  = '/var/moodledata';
$CFG->admin     = 'admin';

$CFG->loginredir = "{$CFG->wwwroot}/local/dbedashboard/home.php";
$CFG->logoutredir = "{$CFG->wwwroot}";

$CFG->directorypermissions = 0777;

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
