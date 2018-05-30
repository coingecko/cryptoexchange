require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Exrates::Market do
  it { expect(described_class::NAME).to eq 'exrates' }
  it { expect(described_class::API_URL).to eq 'https://exrates.me/public/coinmarketcap/ticker' }
end
