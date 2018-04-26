require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Btc24::Market do
  it { expect(described_class::NAME).to eq 'btc24' }
  it { expect(described_class::API_URL).to eq 'https://cryptottlivewebapi.btc24.io:8443/api/v1/public' }
end
