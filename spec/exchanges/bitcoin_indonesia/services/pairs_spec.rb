require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitcoinIndonesia::Services::Pairs do
  it { expect(described_class::MARKET::NAME).to eq 'bitcoin_indonesia' }
end
