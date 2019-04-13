require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BinanceDex::Market do
  it { expect(described_class::NAME).to eq 'binance_dex' }
  it { expect(described_class::API_URL).to eq 'https://testnet-dex.binance.org/api/v1' }
end
