require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coineal::Market do
  it { expect(described_class::NAME).to eq 'coineal' }
  it { expect(described_class::API_URL).to eq 'https://exchange-open-api.coineal.com/open/api' }
end
