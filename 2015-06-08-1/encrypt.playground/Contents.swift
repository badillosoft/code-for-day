// Alan Badillo Salas
// @badillosoft | badillo.soft@hotmail.com

// Este programa codifica un mensaje bajo el método César
// El método se basa en recorrer los caracteres k posiciones
// Por ejemplo:
// 		Mensaje: Hola	Clave: 3
//		Mensaje encriptado: Krod

// Note: On IOS App we need to remove .value from u[u.startIndex].value

// Convierte un caracter en entero
// Converts a character to integer
func charToInt(c: Character) -> Int {
	let u = String(c).unicodeScalars
	
	return Int(u[u.startIndex].value)
}

// Convierte un entero en caracter
// Converts an integer to character
func intToChar(x: Int) -> Character {
	let s = UnicodeScalar(x)
	return Character("\(s)")
}

// Dado un conjunto de pares de rangos, determina cual es el primer rango que contiene a x
// Gets the first range contains to x, all range are defined by periodic-tuples
func inRange(x: Int, pairs: (Int, Int)...) -> (minimum: Int, maximum: Int) {
	for (minimum: Int, maximum: Int) in pairs {
		if x >= minimum && x <= maximum {
			return (minimum, maximum)
		}
	}
	
	return (-1, -1)
}

// Definimos la función encrypt la cual toma una cadena y una clave y devuelve la cadena codificada
// Gets the encode message, from any alphabet message.
func encrypt(message s: String, key k: Int) -> String {
	var messageEncrypt = ""
	
	let AZ = (charToInt("A"), charToInt("Z"))
	let az = (charToInt("a"), charToInt("z"))
	
	for c in s {
		let x = charToInt(c)
		
		let range = inRange(x, AZ, az)
		
		var z = x + k
		
		if z > range.maximum {
			z = (range.minimum - 1) + (z - range.maximum)
		} else if z < range.minimum {
			z = (range.maximum + 1) - (range.minimum - z)
		}
		
		if range.minimum == -1 && range.maximum == -1 {
			z = x
		}
		
		messageEncrypt += "\(intToChar(z))"
	}
	
	return messageEncrypt
}

encrypt(message: "Hola! Como estas?", key: 3)

encrypt(message: "Krod", key: 3)

encrypt(message: "Hola", key: 6)

encrypt(message: "Krod", key: -3)

encrypt(message: "Zebra", key: 10)

encrypt(message: "Jolbk", key: -10)
