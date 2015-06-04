<?php

// Alan Badillo Salas
// @badillosoft | badillo.soft@hotmail.com

// Definimos las variables a enviar en el JSON
$err = true;
$msg = 'No se recibió la variable "msg"';

// Asignamos el mensaje si fue recibido mediante GET
if (isset($_GET['msg'])) {
	$err = false;
	$msg = $_GET['msg'];
}

// Asignamos el mensaje si fue recibido mediante POST
if (isset($_POST['msg'])) {
	$err = false;
	$msg = $_POST['msg'];
}

// Devolvemos un JSON generado mediante json_encode
// y un arreglo estilo clave => valor
echo json_encode(
	array(
		"error" => $err,
		"message" => $msg
	)
);

?>