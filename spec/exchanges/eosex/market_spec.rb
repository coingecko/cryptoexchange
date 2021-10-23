require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Eosex::Market do
  it { expect(described_class::NAME).to eq 'eosex' }
  it { expect(described_class::API_URL).to eq 'https://api.eosex.com/exchange/tickers' }
end
