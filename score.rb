class Score
	class UndefinedTerm < RuntimeError; end
	def initialize(data = "")
		@row = data.gsub('-', '0').split('')
		@stack = []       # data stack
		@pc = @row.size-1 # program counter
		@score = 0        # result
	end
	def score
		while @pc >= 0 do
			ch = @row[@pc]
			case ch
				when '0'..'9'
					@stack.push(ch.to_i)
					@score += (ch.to_i)
				when 'X' # strike
					if @stack.size >= 2
						@nnext = @stack[-2]
						@next = @stack[-1]
						@score += (10 + @next + @nnext)
					end
					@stack.push(10)
				when '/' # spare
					if @stack.size > 1
						@next = @stack[-1]
						@score += @next
					end
					spr_ch = @row[@pc-1]
					@stack.push(10 - spr_ch.to_i)
					@score += 10 - spr_ch.to_i
				else
					raise UndefinedTerm
			end
			#print("row: ", @row, "\n");
			#print("stk: ", @stack, "\n");
			#print("ch: ", ch, "(", @pc, ")\n")
			#print("scr: ", @score, "\n");
			@pc -= 1
		end
		return @score
	end
end

@score = Score.new('XXXXXXXXXXXX')
@score = Score.new('9-9-9-9-9-9-9-9-9-9-')
#@score = Score.new('5/5/5/5/5/5/5/5/5/5/5')
print("score: ", @score.score, "\n")
