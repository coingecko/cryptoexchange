require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::ThreeXbit::Market do
  it { expect(described_class::NAME).to eq 'three_xbit' }
  it { expect(described_class::API_URL).to eq 'https://api.exchange.3xbit.com.br' }
end
