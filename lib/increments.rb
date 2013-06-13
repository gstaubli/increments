module Increments
	def self.increment(opts={})
		options = default_options.merge(opts)
        validate(options)
        min, max = options[:min], [options[:min] + options[:increment]-1, options[:max]].min
    	until max >= options[:max]
    		yield(min,max)
    		min = [min + options[:increment], options[:max]].min # Never exceed specified maximum
    		max = [max + options[:increment], options[:max]].min
    	end
	end

	def self.default_options
		{
			:min => 0, 
			:max => 4294967295, 
            :increment => 100000 
        }
	end

	def self.number_of_batches(options)
		((options[:max]-options[:min]+1.to_f)/options[:increment]).ceil
	end

	def self.validate(options)
		raise ArgumentError, "Invalid Options: #{options}" if options[:min] > options[:max] || options[:increment] <= 0
	end
end