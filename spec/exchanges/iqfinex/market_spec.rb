require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Iqfinex::Market do
  it { expect(described_class::NAME).to eq 'iqfinex' }
  it { expect(described_class::API_URL).to eq 'https://datacenter.iqfinex.com' }
end
