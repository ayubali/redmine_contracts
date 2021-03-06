require File.dirname(__FILE__) + '/../test_helper'

class FixedBudgetTest < ActiveSupport::TestCase
  should_belong_to :deliverable

  context "#markup_value" do
    setup do
      @fixed_budget = FixedBudget.new(:budget => 1000)
    end
    
    context "with no markup" do
      should "be 0" do
        assert_equal nil, @fixed_budget.markup
        assert_equal 0, @fixed_budget.markup_value
      end
    end

    context "with a % markup" do
      should "equal the budget times the %" do
        @fixed_budget.markup = '50%'
        assert_equal 500, @fixed_budget.markup_value
      end
    end

    context "with a $ markup" do
      should "equal the $ markup (straight markup)" do
        @fixed_budget.markup = '$4,000.57'
        assert_equal 4000.57, @fixed_budget.markup_value
      end

      should "work without the $ sign" do
        @fixed_budget.markup = '4,000.57'
        assert_equal 4000.57, @fixed_budget.markup_value
      end
      
    end

    context "with a straight amount of markup" do
      should "equal the markup" do
        @fixed_budget.markup = 4000.57
        assert_equal 4000.57, @fixed_budget.markup_value
      end
    end
    
  end

  context "#budget=" do
    setup do
      @fixed_budget = FixedBudget.new
    end
    
    should "allow a $ string" do
      @fixed_budget.budget = '$1,000.00'
      assert_equal 1000.00, @fixed_budget.budget
    end
    
    should "allow a plain string" do
      @fixed_budget.budget = '1,000.00'
      assert_equal 1000.00, @fixed_budget.budget
    end
    
    should "allow a numeric value" do
      @fixed_budget.budget = 1000.00
      assert_equal 1000.00, @fixed_budget.budget
    end
    
  end
  
end
