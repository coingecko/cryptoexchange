require 'spec_helper'

RSpec.describe Cryptoexchange::Client do
  it 'loads every available exchanges according to folder name' do
    available_exchanges = %w(
                            btcc
                            anx
                            bitcoin_indonesia
                            bitflyer
                            ccex
                            coincheck
                            coinone
                            korbit
                            cryptopia
                            gatecoin
                            lakebtc
                            livecoin
                            bitstamp
                            okcoin
                            novaexchange
                            liqui
                            gemini
                            hitbtc
                            bithumb
                            ether_delta
                          ).sort
    expect(described_class.available_exchanges).to eq available_exchanges

  end
end
