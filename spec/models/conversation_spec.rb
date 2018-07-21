require "rails_helper"

RSpec.describe Conversation, type: :model do
  describe Conversation do
    it { is_expected.to validate_presence_of(:sender_id) }
    it { is_expected.to validate_presence_of(:recipient_id) }
  end
end
