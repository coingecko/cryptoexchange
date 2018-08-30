require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::FiftyEightCoin::Market do
  it { expect(Cryptoexchange::Exchanges::FiftyEightCoin::Market::NAME).to eq 'fifty_eight_coin' }
  it { expect(Cryptoexchange::Exchanges::FiftyEightCoin::Market::API_URL).to eq 'https://api.58coin.com/v1' }
end
