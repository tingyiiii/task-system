require "rails_helper"

RSpec.describe Task, type: :model do
  let(:subject) { create(:task) }
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:priority) }
    it { is_expected.to define_enum_for(:priority).with_values(%w(low medium high)) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to define_enum_for(:status).with_values(%w(pending processing completed)) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
    it 'validates the task end time is after start time' do
      task = Task.new(start_time: Faker::Time.forward, end_time: Time.now)
      task.validate
      expect(task.errors[:end_time]).to include("#{I18n.t('tasks.end_time_after_start_time')}")
    end
  end
end