require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CoinsMarkets::Services::Pairs do
  it { expect(described_class::PAIRS_URL).to eq 'https://coinsmarkets.com/apicoin.php' }
end
