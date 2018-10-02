require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitcoinIndonesia::Market do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bitcoin_indonesia' }
  let(:ltc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ltc', target: 'btc', market: market) }

  it { expect(described_class::NAME).to eq 'bitcoin_indonesia' }
  it { expect(described_class::API_URL).to eq 'https://vip.bitcoin.co.id/api' }

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: ltc_btc_pair.base, target: ltc_btc_pair.target
    expect(trade_page_url).to eq 'https://indodax.com/market/LTCBTC'
  end
end
