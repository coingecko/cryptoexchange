require 'spec_helper'

RSpec.describe 'MercadoNiobioCash integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:nbr_brl_pair) { Cryptoexchange::Models::MarketPair.new(base: 'NBR', target: 'BRL', market: 'mercado_niobio_cash') }

  it 'fetch pairs' do
    pairs = client.pairs('mercado_bitcoin')
    expect(pairs).not_to be_empty

    expected_base = %w(NBR)
    expect(pairs.map(&:base)).to match_array expected_base
    expect(pairs.map(&:target).uniq).to eq %w(BRL)
    expect(pairs.map(&:market).uniq).to eq %w(mercado_bitcoin)
  end

  it 'fetch ticker' do
    ticker = client.ticker(nbr_brl_pair)

    expect(ticker.base).to eq 'NBR'
    expect(ticker.target).to eq 'BRL'
    expect(ticker.market).to eq 'mercado_niobio_cash'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
