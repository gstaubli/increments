### Summary
This Gem intends to provide a simple module to handle incrementing through a set of values.

### Usage
	Increments.increment(:min => 0, :max => 100000, :increment => 10000) do |min,max|
		puts "Min: #{min} - Max: #{max}"
	end

	Increments.decrement(:min => 0, :max => 100000, :increment => 10000) do |min,max|
		puts "Min: #{min} - Max: #{max}"
	end