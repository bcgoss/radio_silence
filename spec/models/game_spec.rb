require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'enums' do
    it { should define_enum_for(:status)
      .with_values([:pending, :in_progress, :finished, :archived]) }
  end
  
  it { should belong_to(:owner) }
  it { should have_many(:players) }
  
end
