// Alan Badillo Salas
// @badillosoft | badillo.soft@hotmail.com
// Código del día: miércoles 3 de junio de 2014

// Al cargar la ventana hace una petición tipo GET y luego una tipo POST
// - se envia un parámetro un mensaje
// - se recibe un documento JSON y lo convertimos a un objeto JS

// Cambiamos el comportamiento del evento onload generado al cargarse la ventana
window.onload = function () {
	// Creamos una función que procese los datos recibidos del servidor
	var callback = function (data) {
		// Convertimos el documento JSON recibido del servidor
		// a un objeto de JavaScript
		var obj = JSON.parse(data);
		
		// Mostramos el objeto en la consola
		console.log(obj);
	};
	
	// Mediante JQuery hacemos la petición de tipo GET
	$.get('http://localhost/test/2015-06-03-1/echo_json.php', {msg: 'Hello GET'}).done(callback);
	
	// Mediante JQuery hacemos la petición de tipo POST
	$.post('http://localhost/test/2015-06-03-1/echo_json.php', {msg: 'Hello POST'}).done(callback);
}