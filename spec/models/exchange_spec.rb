require 'spec_helper'

describe Exchange do

  before { FactoryGirl.build(:exchange) }

  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }

end
