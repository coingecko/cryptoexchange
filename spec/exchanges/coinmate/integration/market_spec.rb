require 'spec_helper'

RSpec.describe 'CoinMate integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('coinmate')
    expect(pairs).not_to be_empty

    pairs.each do |pair|
      expect(pair.base).to_not be nil
      expect(pair.target).to_not be nil
      expect(pair.market).to eq 'coinmate'
    end
  end

  it 'fetch ticker' do
    btc_usd_pair = Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'czk', market: 'coinmate')
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'CZK'
    expect(ticker.market).to eq 'coinmate'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(DateTime.strptime(ticker.timestamp.to_s, '%s').year).to eq Date.today.year
    expect(ticker.payload).to_not be nil
  end

end
