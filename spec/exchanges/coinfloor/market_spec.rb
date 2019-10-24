require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinfloor::Market do
  it { expect(described_class::NAME).to eq 'coinfloor' }
  it { expect(described_class::API_URL).to eq 'https://webapi.coinfloor.co.uk/bist' }
end
