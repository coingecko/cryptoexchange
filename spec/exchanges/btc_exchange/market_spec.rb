require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BtcExchange::Market do
  it { expect(described_class::NAME).to eq 'btc_exchange' }
  it { expect(described_class::API_URL).to eq 'https://api.btc-exchange.com/papi/web' }
end
