require 'spec_helper'

RSpec.describe 'Uniswap integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:dai_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: '0x6b175474e89094c44da98b954eedeac495271d0f', target: 'eth', market: 'uniswap') }
  let(:sxau_usdc_pair) { Cryptoexchange::Models::MarketPair.new(base: '0x261efcdd24cea98652b9700800a13dfbca4103ff', target: 'eth', market: 'uniswap') }

  let(:filename) { Cryptoexchange::Credentials.send(:filename) }

  before do
    allow(Cryptoexchange::Credentials).to receive(:get).with('uniswap').and_return({ 'api_key' => 'test_key' })
  end

  describe "fetch pairs" do
    before do
      @pairs = client.pairs('uniswap')
    end
    it "has ETH target pair" do
      expect(@pairs.select { |pair| pair.target_raw == "ETH" }.any?).to be true
    end
  end

  it 'fetch ticker dai/eth' do
    ticker = client.ticker(dai_eth_pair)

    expect(ticker.base).to eq '0X6B175474E89094C44DA98B954EEDEAC495271D0F'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'uniswap'

    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric

    expect(ticker.payload).to_not be nil
  end

  it 'fetch ticker sxau/eth' do
    ticker = client.ticker(sxau_usdc_pair)

    expect(ticker.base).to eq '0X261EFCDD24CEA98652B9700800A13DFBCA4103FF'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'uniswap'

    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric

    expect(ticker.payload).to_not be nil
  end
end
