require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Financex::Market do
  it { expect(described_class::NAME).to eq 'financex' }
  it { expect(described_class::API_URL).to eq 'https://market-watch.financex.io/api/v1/market-watch/ticker' }
end
