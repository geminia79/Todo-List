require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:identities).dependent(:destroy) }
    it { is_expected.to have_many(:products).dependent(:destroy) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { expect(User.new(email: "xyx")).to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
    it { is_expected.to validate_confirmation_of(:password) }
  end

  context 'instance methods' do
    context '#admin?' do
      context 'when is_admin is true' do
        subject { User.new(is_admin: true).admin? }
        it { is_expected.to eq(true)}
      end

      context 'when is_admin is false' do
        subject { User.new(is_admin: false).admin? }
        it { is_expected.to eq(false)}
      end

      context 'when is_admin is nil' do
        subject { User.new(is_admin: nil).admin? }
        it { is_expected.to eq(false)} 
      end
    end
  end
end
