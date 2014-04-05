require 'spec_helper'

describe Team do
  describe '#add_owner_to_members' do
    it 'creates team member for new team' do
      team = FactoryGirl.create(:team)
      expect(team.members).to eq [team.owner]
    end
  end
end
