require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tokenomy::Market do
  it { expect(described_class::NAME).to eq 'tokenomy' }
  it { expect(described_class::API_URL).to eq 'https://exchange.tokenomy.com/api' }
end
