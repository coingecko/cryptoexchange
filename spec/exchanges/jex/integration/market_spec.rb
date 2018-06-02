require 'spec_helper'

RSpec.describe 'Jex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ltc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'LTC', target: 'BTC', market: 'jex') }
  let(:derivatives) {
                      {"ltc/btc": {
                                    "id": 6,
                                    "last": "0.01567100",
                                    "lowestAsk": "0.01571800",
                                    "highestBid": "0.01562600",
                                    "percentChange": "0.0030000000",
                                    "baseVolume": "70834.04420000",
                                    "quoteVolume": "1113.40985817",
                                    "isFrozen": "0",
                                    "high24hr": "0.01583000",
                                    "low24hr": "0.01554700"
                                  },
                      "火币ETF": {
                                  "id": 15,
                                  "last": "0.00020108",
                                  "lowestAsk": "0.00020150",
                                  "highestBid": "0.00020072",
                                  "percentChange": "0.0033000000",
                                  "baseVolume": "18255786.00000000",
                                  "quoteVolume": "3638.50307581",
                                  "isFrozen": "0",
                                  "high24hr": "0.00020110",
                                  "low24hr": "0.00019679"
                                },
                      "TRX/USDT 0.07 CALL 2018/06/07": {
                                  "id": 214,
                                  "last": "0.61160000",
                                  "lowestAsk": "0.62150000",
                                  "highestBid": "0.60780000",
                                  "percentChange": "0.0385000000",
                                  "baseVolume": "798077.00000000",
                                  "quoteVolume": "475160.44400000",
                                  "isFrozen": "0",
                                  "high24hr": "0.65060000",
                                  "low24hr": "0.55010000"
                                },
                      "HT/USDT 3.83 PUT 2018/06/01": {
                                  "id": 196,
                                  "last": "0.00300000",
                                  "lowestAsk": "0.00370000",
                                  "highestBid": "0.00230000",
                                  "percentChange": "-0.7478000000",
                                  "baseVolume": "6660824.00000000",
                                  "quoteVolume": "582757.45350000",
                                  "isFrozen": "0",
                                  "high24hr": "0.27540000",
                                  "low24hr": "0.00180000"
                                }}
                    }

  it 'fetch pairs' do
    pairs = client.pairs('jex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'jex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(ltc_btc_pair)

    expect(ticker.base).to eq 'LTC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'jex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'check derivatives removed' do
    pairs_classname = "Cryptoexchange::Exchanges::Jex::Services::Pairs"
    pairs_class = Object.const_get(pairs_classname)
    pairs_object = pairs_class.new

    market_pairs = []
    derivatives.each do |pair|
      key = pair[0].to_s
      if !pairs_object.derivative(key)
        market_pairs << pair
      end
    end
    expect(market_pairs.length).to eq 1
  end

end
