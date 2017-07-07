require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinone::Services::Pairs do
  it { expect(described_class::MARKET::NAME).to eq 'coinone' }
end
