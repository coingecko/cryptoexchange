require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Btcturk::Market do
  it { expect(described_class::NAME).to eq 'btcturk' }
  it { expect(described_class::API_URL).to eq 'https://www.btcturk.com/api' }
end
