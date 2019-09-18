module Cryptoexchange::Exchanges
  module Deribit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def fetch
          btc_pairs = fetch_via_api(btc_pairs_url)
          eth_pairs = fetch_via_api(eth_pairs_url)
          adapt(btc_pairs["result"] + eth_pairs["result"])
        end

        def btc_pairs_url
          "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/get_instruments?currency=BTC&kind=future&expired=false"
        end

        def eth_pairs_url
          "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/get_instruments?currency=ETH&kind=future&expired=false"
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['base_currency'],
                              target: pair['quote_currency'],
                              market: Deribit::Market::NAME,
                              inst_id: pair['instrument_name']
                            )
          end
          market_pairs
        end
      end
    end
  end
end
