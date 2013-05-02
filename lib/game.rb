require 'person'

class Frame
	def initialize(person = nil)
		@person = person
		@result = ""
	end

	def start
		@result = @person.firstThrow
		if @result != 'X' then
			@result += @person.secondThrow
		end
		return @result
	end
end

class ExtraFrame < Frame
	def initialize(person = nil)
		super(person)
	end

	def start
		@result = @person.firstThrow
		if @result != 'X' then
			@result += @person.secondThrow
			if @result.end_with?('/') then
				@result += @person.firstThrow
			end
		else
			@result += @person.firstThrow
			@result += @person.firstThrow
		end
		return @result
	end
end

class Game
	def initialize
		@frm = Frame.new(Person.new)
	end

	def start
		result = ""
		for i in 0..8
			result += @frm.start
		end
		efrm = ExtraFrame.new(Person.new)
		result += efrm.start
		return result
	end
end

if __FILE__ == $0
	game = Game.new
	fout = File.open('../gen/bowling_input.txt', 'w')
	for i in 1..1000
		fout.write(game.start + "\n")
	end
	fout.close
end
