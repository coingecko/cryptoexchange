require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BtcAlpha::Market do
  it { expect(described_class::NAME).to eq 'btc_alpha' }
  it { expect(described_class::API_URL).to eq 'https://btc-alpha.com/api/v1' }
  it { expect(described_class::TICKER_URL).to eq 'https://btc-alpha.com/api' }
end
