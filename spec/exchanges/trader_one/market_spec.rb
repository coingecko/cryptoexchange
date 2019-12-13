require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TraderOne::Market do
  it { expect(described_class::NAME).to eq 'trader_one' }
  it { expect(described_class::API_URL).to eq 'https://api.traderone.exchange' }
end