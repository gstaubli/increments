require 'spec_helper'

describe Increments do
  before(:each) do
    @options = { :min       => 1, 
                 :max       => 5000, 
                 :increment => 1000 }
  end

  describe "#increment" do
    describe "success" do
      it "should build valid incrementing batches" do
        batches = []
        Increments.increment(@options) { |min,max| batches << [min,max] }
        batches.should == [[1, 1000], [1001, 2000], [2001, 3000], [3001, 4000], [4001, 5000]]
      end

      it "should build a valid incrementing batch with same min and max" do
        @options[:min] = @options[:max]
        batches = []
        Increments.increment(@options) { |min,max| batches << [min,max] }
        batches.should == [[5000,5000]]
      end

      it "should not have overlapping range values" do
        range_values = []
        Increments.increment(@options) { |min,max| range_values << min << max }
        range_values.uniq.size.should == range_values.size
      end
    end
    
    describe "failure" do
      it "should throw an error when passed without a block" do
        lambda do
          Increments.increment(@options)
        end.should raise_error(LocalJumpError,"no block given (yield)")
      end

      it "should throw an error when passed with an invalid min and max" do
        @options[:min] = @options[:max] + 1
        lambda do
          Increments.increment(@options) { |min,max| }
        end.should raise_error(ArgumentError,/^Invalid Options/)
      end
    end
  end

  describe "#decrement" do
    describe "success" do
      it "should build valid decrementing batches" do
        batches = []
        Increments.decrement(@options) { |min,max| batches << [min,max] }
        batches.should == [[4001, 5000], [3001, 4000], [2001, 3000], [1001, 2000], [1, 1000]]
      end

      it "should build a valid decrementing batch with same min and max" do
        @options[:min] = @options[:max]
        batches = []
        Increments.decrement(@options) { |min,max| batches << [min,max] }
        batches.should == [[5000,5000]]
      end

      it "should not have overlapping range values" do
        range_values = []
        Increments.decrement(@options) { |min,max| range_values << min << max }
        range_values.uniq.size.should == range_values.size
      end
    end
    
    describe "failure" do
      it "should throw an error when passed without a block" do
        lambda do
          Increments.decrement(@options)
        end.should raise_error(LocalJumpError,"no block given (yield)")
      end

      it "should throw an error when passed without an invalid min and max" do
        @options[:min] = @options[:max] + 1
        lambda do
          Increments.decrement(@options) { |min,max| }
        end.should raise_error(ArgumentError,/^Invalid Options/)
      end
    end
  end
end