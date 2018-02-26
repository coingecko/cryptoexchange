require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitflip::Market do
  it { expect(described_class::NAME).to eq 'bitflip' }
  it { expect(described_class::API_URL).to eq 'https://api.bitflip.cc/method/' }
end
