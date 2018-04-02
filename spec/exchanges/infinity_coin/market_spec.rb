require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::InfinityCoin::Market do
  it { expect(described_class::NAME).to eq 'infinity_coin' }
  it { expect(described_class::API_URL).to eq 'https://infinitycoin.exchange' }
end
