require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::SafeTrade::Market do
  it { expect(described_class::NAME).to eq 'safe_trade' }
  it { expect(described_class::API_URL).to eq 'https://safe.trade/api' }
end
