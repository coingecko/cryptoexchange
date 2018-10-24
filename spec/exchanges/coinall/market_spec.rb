require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinall::Market do
  it { expect(described_class::NAME).to eq 'coinall' }
  it { expect(described_class::API_URL).to eq 'https://www.coinall.com/api' }
end
