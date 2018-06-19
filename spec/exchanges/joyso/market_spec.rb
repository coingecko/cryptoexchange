require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Joyso::Market do
  it { expect(described_class::NAME).to eq 'joyso' }
  it { expect(described_class::API_URL).to eq 'https://joyso.io/api/v1' }
end
