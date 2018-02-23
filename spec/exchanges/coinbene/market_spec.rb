require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinbene::Market do
  it { expect(described_class::NAME).to eq 'coinbene' }
  it { expect(described_class::API_URL).to eq 'http://api.coinbene.com/v1' }
end
