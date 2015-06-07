<?php

// Alan Badillo Salas
// @badillosoft | badillo.soft@hotmail.com

// Definimos una función para obtener una variable a través de get o post
// Adicionalmente si la variable no está definida o el método es inválido
// devolvemos un JSON con argumentos de error y mensaje
function get_var($name, $method = 'ANY', $kill = true) {
	$var = null;
	
	if ($method == 'GET' || $method == 'ANY') {
		if (isset($_GET[$name])) {
			$var = $_GET[$name];
		}
	} else if ($method == 'POST' || $method == 'ANY') {
		if (isset($_POST[$name])) {
			$var = $_POST[$name];
		}
	} else if ($kill) {
		echo json_encode(
			array(
				"error" => true,
				"error_no" => 1,
				"message" => "Invalid method, try: GET, POST or ANY"
			)
		);
		exit();
	}
	
	if ($var == null && $kill) {
		echo json_encode(
			array(
				"error" => true,
				"error_no" => 2,
				"message" => "The $name-var is not defined"
			)
		);
		exit();
	}
	
	return $var;
}

$name = get_var('name');
$last = get_var('last');

echo json_encode(
	array(
		"error" => false,
		"error_no" => 0,
		"message" => "Hello $name, is $last your last name?"
	)
);

?>