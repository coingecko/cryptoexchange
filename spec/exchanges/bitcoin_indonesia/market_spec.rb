require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitcoinIndonesia::Market do
  it { expect(Cryptoexchange::Exchanges::BitcoinIndonesia::Market::NAME).to eq 'bitcoin_indonesia' }
  it { expect(Cryptoexchange::Exchanges::BitcoinIndonesia::Market::API_URL).to eq 'https://vip.bitcoin.co.id/api' }
end
