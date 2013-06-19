require 'spec_helper'

describe Increments do
  before(:each) do
    @options = { 
                  :min => 1, 
                  :max => 5000, 
                  :increment => 1000 
               }
  end

  describe "increment" do
    describe "success" do
      it "should build valid incrementing batches" do
        Increments.increment(@options) do |min,max|
          (min <= @options[:max]).should be_true
          (max <= @options[:max]).should be_true
          (min <= max).should be_true
          (max-min <= @options[:increment]).should be_true
        end
      end
      it "should build a valid incrementing batch with same min and max" do
        @options[:min] = @options[:max]
        Increments.increment(@options) do |min,max|
          (min <= @options[:max]).should be_true
          (max <= @options[:max]).should be_true
          (min <= max).should be_true
          (max-min <= @options[:increment]).should be_true
        end
      end
    end
    
    describe "failure" do
      it "should throw an error when passed without a block" do
        lambda do
          Increments.increment(@options)
        end.should raise_error(LocalJumpError,"no block given (yield)")
      end

      it "should throw an error when passed without an invalid min and max" do
        @options[:min] = 10000
        @options[:max] = 9999
        lambda do
          Increments.increment(@options) { |min,max| }
        end.should raise_error(ArgumentError,/^Invalid Options/)
      end
    end
  end

  describe "decrement" do
    describe "success" do
      it "should build valid decrementing batches" do
        Increments.decrement(@options) do |min,max|
          (min <= @options[:max]).should be_true
          (max <= @options[:max]).should be_true
          (min <= max).should be_true
          (max-min <= @options[:increment]).should be_true
        end
      end
      it "should build a valid decrementing batch with same min and max" do
        @options[:min] = @options[:max]
        Increments.decrement(@options) do |min,max|
          (min <= @options[:max]).should be_true
          (max <= @options[:max]).should be_true
          (min <= max).should be_true
          (max-min <= @options[:increment]).should be_true
        end
      end
    end
    
    describe "failure" do
      it "should throw an error when passed without a block" do
        lambda do
          Increments.decrement(@options)
        end.should raise_error(LocalJumpError,"no block given (yield)")
      end

      it "should throw an error when passed without an invalid min and max" do
        @options[:min] = 10000
        @options[:max] = 9999
        lambda do
          Increments.decrement(@options) { |min,max| }
        end.should raise_error(ArgumentError,/^Invalid Options/)
      end
    end
  end
end