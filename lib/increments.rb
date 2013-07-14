module Increments
	def self.increment(opts={},&block)
		options = defaults.merge(opts)
        validate(options,&block)
        step_enum(options) do |min|
			yield(min,range_max(min,options))
		end
	end

	def self.decrement(opts={},&block)
		options = defaults.merge(opts)
		validate(options,&block)
		step_enum(options).reverse_each do |min|
			yield(min,range_max(min,options))
		end
	end

	private

		def self.range_max(min,options)
			[min + options[:increment]-1,options[:max]].min
		end

		def self.step_enum(options)
			(options[:min]..options[:max]).step(options[:increment])
		end

		def self.defaults
			{
				:min => 0, 
				:max => 4294967295, 
	            :increment => 100000 
	        }
		end

		def self.validate(options)
			raise ArgumentError, "Invalid Options: #{options}" if options[:min] > options[:max] || options[:increment] <= 0
			raise LocalJumpError, "no block given (yield)" unless block_given?
		end
end