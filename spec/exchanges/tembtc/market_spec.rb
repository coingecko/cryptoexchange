require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TemBTC::Market do
  it { expect(described_class::NAME).to eq 'tembtc' }
  it { expect(described_class::API_URL).to eq 'https://broker.tembtc.com.br/api/v3/' }
end
