require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Orderbook::Market do
  it { expect(described_class::NAME).to eq 'orderbook' }
  it { expect(described_class::API_URL).to eq 'https://api.orderbook.io' }
end
