require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinut::Services::Pairs do
  it { expect(described_class::PAIRS_URL).to eq 'https://api.coinut.com' }
end
