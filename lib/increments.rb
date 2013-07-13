module Increments
	def self.increment(opts={})
		options = defaults.merge(opts)
        validate(options)
        min, max = options[:min], [options[:min] + options[:increment]-1, options[:max]].min
    	loop do
    		yield(min,max)
    		break if max == options[:max]
			min = [min + options[:increment], options[:max]].min
			max = [max + options[:increment], options[:max]].min
    	end
	end

	def self.decrement(opts={})
		options = defaults.merge(opts)
		validate(options)
		min, max = [options[:min], options[:max] - options[:increment]+1].max, options[:max]
		loop do
			yield(min,max)
			break if min == options[:min]
			min = [min - options[:increment], options[:min]].max
    		max = [max - options[:increment], options[:min]].max
		end
	end

	private

		def self.defaults
			{
				:min => 0, 
				:max => 4294967295, 
	            :increment => 100000 
	        }
		end

		def self.validate(options)
			raise ArgumentError, "Invalid Options: #{options}" if options[:min] > options[:max] || options[:increment] <= 0
		end
end