# Alan Badillo Salas
# @badillosoft | badillo.soft@hotmail.com

# This code separates an expresion in parts.
# An "expresion" is an string containts ()-brackets
# The separate result is an array with separate parts
# The result is similar to "xx(yy)xx(yy(zz))" => ["xx",["yy"], "xx", ["yy", ["zz"]]]

def separate(expr):
	#print {">": expr}
	parts = []
	
	count = 0
	part = ''
	sub = ''
	for c in expr:
		if c == '(':
			count += 1
			if count > 1:
				sub += c
			else:
				parts.append(part)
				part = ''
		elif c == ')':
			count -= 1
			if count > 0:
				sub += c
			if count == 0:
				if sub != '':
					parts.append(separate(sub))
					sub = ''
		else:
			if count > 0:
				sub += c
			else:
				part += c
	if sub != '':
		parts.append(separate(sub))
	if part != '':
		parts.append(part)
		
	return parts

if __name__ == "__main__":
	print separate('xx(yy)xx(yy(zz))')
	print separate('xx(yy)xx(yy(zz))xx')
	print separate('1 + 2 * (3 + (5 - 2) * 4 * (2 + (1 + 2) / (1 - 2)) / (5 + 6) * 3')