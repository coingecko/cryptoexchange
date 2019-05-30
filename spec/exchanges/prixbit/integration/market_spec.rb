require 'spec_helper'

RSpec.describe 'Prixbit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'prixbit' }
  let(:snt_krw_pair) { Cryptoexchange::Models::MarketPair.new(base: 'snt', target: 'krw', market: 'prixbit') }

  it 'fetch pairs' do
    double = instance_double("Cryptoexchange::Exchanges::Prixbit::Services::Pairs")
    # Stub date to VCR query date to prixbit, if VCR changes, update this date
    Cryptoexchange::Exchanges::Prixbit::Services::Pairs.any_instance.stub(:date_now){ Date.new(2019,5,28) }

    pairs = client.pairs('prixbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'prixbit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: snt_krw_pair.base, target: snt_krw_pair.target
    expect(trade_page_url).to eq "https://www.prixbit.com/exc/exchange.do?baseCrncyCd=KRW&crncyCd=SNT"
  end

  it 'fetch ticker' do
    double = instance_double("Cryptoexchange::Exchanges::Prixbit::Services::Pairs")
    # Stub date to VCR query date to prixbit, if VCR changes, update this date
    Cryptoexchange::Exchanges::Prixbit::Services::Market.any_instance.stub(:date_now){ Date.new(2019,5,28) }

    ticker = client.ticker(snt_krw_pair)

    expect(ticker.base).to eq 'SNT'
    expect(ticker.target).to eq 'KRW'
    expect(ticker.market).to eq 'prixbit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
