class Person
	def initialize
		@preScore = 0
	end
	def firstThrow
		s = rand(11) # -123456789X
		@preScore = s
		case s
		when 1..9
			return s.to_s
		when 0
			return '-'
		else
			@preScore = 0
			return 'X'
		end
	end
	def secondThrow
		s = rand(11 - @preScore) # -123456789X
		ret = ''
		case s
		when 1..9
			if (s + @preScore) >= 10 then
				ret = '/'
			elsif
				ret = s.to_s
			end
		when 0
			ret = '-'
		else
			ret = '/'
		end
		@preScore = 0
		return ret
	end
	def clear
		@preScore = 0
	end
end
