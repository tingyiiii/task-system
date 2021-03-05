require "rails_helper"

RSpec.describe Task, type: :model do
  let(:subject) { create(:task) }
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:priority) }
    it { is_expected.to validate_inclusion_of(:priority).in_array([*0..2]) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_inclusion_of(:status).in_array([*0..2]) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
  end
end