require 'rails_helper'

RSpec.describe Authentication, type: :model do
  describe 'アソシエーションのテスト' do
    it 'userに属していること' do
      assoc = Authentication.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end