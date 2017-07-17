require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitcoinIndonesia::Market do
  it { expect(described_class::NAME).to eq 'bitcoin_indonesia' }
  it { expect(described_class::API_URL).to eq 'https://vip.bitcoin.co.id/api' }
end
