require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinone::Market do
  it { expect(Cryptoexchange::Exchanges::Coinone::Market::NAME).to eq 'coinone' }
  it { expect(Cryptoexchange::Exchanges::Coinone::Market::API_URL).to eq 'https://api.coinone.co.kr' }
end
