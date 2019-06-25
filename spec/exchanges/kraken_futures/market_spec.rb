require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::KrakenFutures::Market do
  it { expect(described_class::NAME).to eq 'kraken_futures' }
  it { expect(described_class::API_URL).to eq 'https://www.cryptofacilities.com/derivatives/api/v3' }
end
