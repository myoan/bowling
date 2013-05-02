class Score
	class UndefinedTerm < RuntimeError; end
	def score(data = "")
		row = data.gsub('-', '0').split('')
		stack = []       # data stack
		pc = row.size-1 # program counter
		score = 0        # result
		while pc >= 0 do
			ch = row[pc]
			case ch
				when '0'..'9'
					stack.push(ch.to_i)
					score += (ch.to_i)
				when 'X' # strike
					if stack.size > 2
						nnext = stack[-2]
						nxt = stack[-1]
						score += (10 + nxt + nnext)
					elsif stack.size <= 2
						score += 10
					end
					stack.push(10)
				when '/' # spare
					if stack.size > 1
						nxt = stack[-1]
						score += nxt
					end
					spr_ch = row[pc-1]
					stack.push(10 - spr_ch.to_i)
					score += (10 - spr_ch.to_i)
				when "\n"
				else
					puts ch
					raise UndefinedTerm
			end
			pc -= 1
		end
		return score
	end
end

#score = Score.new
#puts score.score('X1/X1/X1/X1/X1/X') # 200
#puts score.score('XXXXXXXXXXXX') # 300
#puts score.score('9-9-9-9-9-9-9-9-9-9-') # 90
#puts score.score('5/5/5/5/5/5/5/5/5/5/5') # 150
#puts score.score('X7/729/XXX236/7/3') # 168
#puts score.score('-1273/X5/7/3454--X7-')# 113
#puts score.score('X7/9-X-88/-6XXX81') # 167

if __FILE__ == $0
	fin  = File.open('../gen/bowling_input.txt', 'r')
	fout = File.open('../gen/bowling_score.txt', 'w')
	score = Score.new
	fin.each do |line|
		fout.write(score.score(line).to_s + "\n")
	end
	fout.close
	fin.close
end
