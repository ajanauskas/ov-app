require 'spec_helper'

describe Team do
  it 'creates team member for new team' do
    team = FactoryGirl.create(:team)
    expect(team.members).to eq [team.owner]
  end
end
