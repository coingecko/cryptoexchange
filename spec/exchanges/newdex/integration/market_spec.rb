require 'spec_helper'

RSpec.describe 'Newdex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:dice_eos_pair) { Cryptoexchange::Models::MarketPair.new(base: 'DICE', target: 'EOS', inst_id: "betdicetoken", market: 'newdex') }

  it 'fetch pairs' do
    pairs = client.pairs('newdex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.inst_id).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'newdex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'newdex', base: dice_eos_pair.base, target: dice_eos_pair.target, inst_id: dice_eos_pair.inst_id
    expect(trade_page_url).to eq "https://newdex.io/trade/betdicetoken-dice-eos"
  end

  it 'fetch ticker' do
    ticker = client.ticker(dice_eos_pair)

    expect(ticker.base).to eq 'DICE'
    expect(ticker.target).to eq 'EOS'
    expect(ticker.inst_id).to eq 'betdicetoken'
    expect(ticker.market).to eq 'newdex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
