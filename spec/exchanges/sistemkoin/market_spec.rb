require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Sistemkoin::Market do
  it { expect(described_class::API_URL).to eq 'https://sistemkoin.com/api/market' }
end
