# Alan Badillo Salas
# @badillo.soft | badillo.soft@hotmail.com
# Octubre 2015

def get_command
	print ":> "
	args = gets.split
	
	command = args[0].to_sym
	args.delete_at(0)
	
	data = Struct.new(:command, :args, :a, :b, :c, :d).new
	
	data.command = command
	data.args = args
	if args.length > 0
		begin
			data.a = Integer(args[0])
		rescue
			puts "The firs argument is not a number"
		end
	end
	if args.length > 1
		begin
			data.b = Integer(args[1])
		rescue
			puts "The second argument is not a number"
		end
	end
	if args.length > 2
		begin
			data.c = Integer(args[2])
		rescue
			puts "The third argument is not a number"
		end
	end
	if args.length > 3
		begin
			data.d = Integer(args[3])
		rescue
			puts "The fourth argument is not a number"
		end
	end
	
	return data
end