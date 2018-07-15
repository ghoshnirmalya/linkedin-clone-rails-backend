require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end
end
