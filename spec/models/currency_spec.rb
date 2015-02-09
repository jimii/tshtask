require 'spec_helper'

describe Currency do

  before { FactoryGirl.build(:currency) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:converter) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:buy_price) }
  it { should validate_presence_of(:sell_price) }

  it { should belong_to(:exchange) }

  it { should validate_numericality_of(:converter) }
  it { should validate_numericality_of(:buy_price) }
  it { should validate_numericality_of(:sell_price) }

end
