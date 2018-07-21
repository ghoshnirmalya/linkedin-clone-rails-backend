require "rails_helper"

RSpec.describe Message, type: :model do
  describe Message do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:conversation_id) }
    it { is_expected.to validate_presence_of(:user_id) }
  end
end
