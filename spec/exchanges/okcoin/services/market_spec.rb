require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Okcoin::Services::Market do

  it 'uses the correct API url for target currency' do
    market = described_class.new
    expect(market.api_url('usd')).to eq Cryptoexchange::Exchanges::Okcoin::Market::INT_API_URL
    expect(market.api_url('cny')).to eq Cryptoexchange::Exchanges::Okcoin::Market::CN_API_URL
  end
end
