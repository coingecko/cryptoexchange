require "spec_helper"

RSpec.describe "StellarTerm integration specs" do
  let(:client) { Cryptoexchange::Client.new }
  let(:rmt_xlm_pair) do
    Cryptoexchange::Models::MarketPair.new(
      base: "RMT",
      base_raw: "RMT-GDEGOXPCHXWFYY234D2YZSPEJ24BX42ESJNVHY5H7TWWQSYRN5ZKZE3N",
      target: "XLM",
      market: Cryptoexchange::Exchanges::StellarTerm::Market::NAME
    )
  end

  it "fetch pairs" do
    pairs = client.pairs(Cryptoexchange::Exchanges::StellarTerm::Market::NAME)
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base_raw).not_to be nil
    expect(pair.base).not_to be nil
    expect(pair.target).not_to be nil
    expect(pair.market).to eq Cryptoexchange::Exchanges::StellarTerm::Market::NAME
  end

  it "fetch ticker" do
    ticker = client.ticker(rmt_xlm_pair)

    expect(ticker.base).to eq "RMT"
    expect(ticker.base_raw).to eq "RMT-GDEGOXPCHXWFYY234D2YZSPEJ24BX42ESJNVHY5H7TWWQSYRN5ZKZE3N"
    expect(ticker.target).to eq "XLM"
    expect(ticker.market).to eq Cryptoexchange::Exchanges::StellarTerm::Market::NAME
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).not_to be nil
  end
end
