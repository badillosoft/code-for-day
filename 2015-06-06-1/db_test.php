<?php

// Alan Badillo Salas
// @badillosoft | badillo.soft@hotmail.com

include_once 'db.php';

$db = new DataBase(null, null, '', 'tuiter');

$db->open();

$data = $db->query("SELECT * FROM usuarios;");

print_r($data);

$gen = function($usuario) {
	$id = $usuario['id'];
	return "SELECT * FROM usuario_tuit WHERE id_usuario=$id;";
};

echo '<br/><br/>';

$data2 = $db->query2("SELECT * FROM usuarios;", $gen);

print_r($data2);

$db->close();
	
?>