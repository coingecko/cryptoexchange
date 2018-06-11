require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Topbtc::Market do
  it { expect(described_class::NAME).to eq 'topbtc' }
  it { expect(described_class::API_URL).to eq 'http://www.topbtc.one/market/tickerall.php' }
end
