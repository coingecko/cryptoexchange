require 'spec_helper'

RSpec.describe 'Uniswap integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:dai_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'dai', target: 'eth', market: 'uniswap') }
  let(:sxau_usdc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'sxau', target: 'usdc', market: 'uniswap') }

  let(:filename) { Cryptoexchange::Credentials.send(:filename) }

  before do
    allow(Cryptoexchange::Credentials).to receive(:get).with('uniswap').and_return({ 'api_key' => 'test_key' })
  end

  describe "fetch pairs" do
    before do
      @pairs = client.pairs('uniswap')
    end

    it "has USDC target pair" do
      expect(@pairs.select { |pair| pair.target == "USDC" }.any?).to be true
    end
    it "has USDT target pair" do
      expect(@pairs.select { |pair| pair.target == "USDT" }.any?).to be true
    end
    it "has DAI target pair" do
      expect(@pairs.select { |pair| pair.target == "DAI" }.any?).to be true
    end
    it "has ETH target pair" do
      expect(@pairs.select { |pair| pair.target == "ETH" }.any?).to be true
    end
  end

  it 'fetch ticker dai/eth' do
    ticker = client.ticker(dai_eth_pair)

    expect(ticker.base).to eq 'DAI'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'uniswap'

    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric

    expect(ticker.payload).to_not be nil
  end

  it 'fetch ticker sxau/usdc' do
    ticker = client.ticker(sxau_usdc_pair)

    expect(ticker.base).to eq 'SXAU'
    expect(ticker.target).to eq 'USDC'
    expect(ticker.market).to eq 'uniswap'

    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric

    expect(ticker.payload).to_not be nil
  end
end
