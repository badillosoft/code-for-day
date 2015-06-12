// Alan Badillo Salas
// @badillosoft | badillo.soft@hotmail.com

extension Character {
	
	func toInt() -> Int {
		let u = String(self).unicodeScalars
		
		return Int(u[u.startIndex].value)
	}
	
}

extension Int {
	
	func toCharacter() -> Character {
		let s = UnicodeScalar(self)
		
		return Character(s)
	}
	
	func inRange(ranges: (minimum: Int, maximum: Int)...) ->
		(minimum: Int, maximum: Int)? {
			for range in ranges {
				if self >= range.minimum && self <= range.maximum {
					return range
				}
			}
			
			return nil
	}
	
}

extension String {
	
	func encrypt(var key: Int) -> String {
		
		var encryptedMessage = ""
		
		var AZ = (Character("A").toInt(), Character("Z").toInt())
		var az = (Character("a").toInt(), Character("z").toInt())
		
		for c in self {
			var x = c.toInt()
			
			var z = x + key
			
			// Realizar el módulo sobre el rango de x
			let xrange = x.inRange(AZ, az)
			
			if let range = xrange {
				if z > range.maximum {
					z = range.minimum - 1 + (z - range.maximum)
				} else if z < range.minimum {
					z = range.maximum + 1 - (range.minimum - z)
				}
			} else {
				z = x
			}
			
			
			encryptedMessage += "\(z.toCharacter())"
		}
		
		return encryptedMessage
	}
	
}


String("Hola! Como estas?").encrypt(3)

String("Krod").encrypt(3)

String("Hola").encrypt(6)

String("Krod").encrypt(-3)

String("Zebra").encrypt(10)

String("Jolbk").encrypt(-10)
