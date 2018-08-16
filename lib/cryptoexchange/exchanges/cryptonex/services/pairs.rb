module Cryptoexchange::Exchanges
  module Cryptonex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL           = "#{Cryptoexchange::Exchanges::Cryptonex::Market::API_URL}"
        HTTP_METHOD         = 'POST'
        POST_PARAMS         = { "id": 2, "jsonrpc": "2.0", "method": "currency_pair.get_rate_list" }

        def fetch
          output = super
          puts output
          adapt(output['result']['rates'])
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base, target = pair['alias'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Cryptonex::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
