### Summary
This Gem intends to provide a simple way to handle range bound incrementing and decrementing by a specified amount. 

### Usage
Providing a min of 0, max of 100000, and an increment of 10000, your output would be as follows:

	Increments.increment(:min => 0, :max => 100_000, :increment => 10_000) do |min,max|
		puts "Min: #{min} - Max: #{max}"
	end

	# => Min: 0 - Max: 9999
		 Min: 10000 - Max: 19999
		 Min: 20000 - Max: 29999
		 Min: 30000 - Max: 39999
		 Min: 40000 - Max: 49999
		 Min: 50000 - Max: 59999
		 Min: 60000 - Max: 69999
		 Min: 70000 - Max: 79999
		 Min: 80000 - Max: 89999
		 Min: 90000 - Max: 99999
		 Min: 100000 - Max: 100000

	Increments.decrement(:min => 0, :max => 100_000, :increment => 10_000) do |min,max|
		puts "Min: #{min} - Max: #{max}"
	end

	# => Min: 90001 - Max: 100000
		  Min: 80001 - Max: 90000
		  Min: 70001 - Max: 80000
		  Min: 60001 - Max: 70000
		  Min: 50001 - Max: 60000
		  Min: 40001 - Max: 50000
		  Min: 30001 - Max: 40000
		  Min: 20001 - Max: 30000
		  Min: 10001 - Max: 20000
		  Min: 1 - Max: 10000
		  Min: 0 - Max: 0
