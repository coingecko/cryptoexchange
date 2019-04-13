require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TrxMarket::Market do
  it { expect(described_class::NAME).to eq 'trx_market' }
  it { expect(described_class::API_URL).to eq 'https://trx.market' }
end
