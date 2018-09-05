module Cryptoexchange::Exchanges
  module Cryptonex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL           = "#{Cryptoexchange::Exchanges::Cryptonex::Market::API_URL}"
        POST_PARAMS         = "{\n  \"id\": 2,\n  \"jsonrpc\": \"2.0\",\n  \"method\": \"currency_pair.get_rate_list\"\n}"

        def fetch
          # byebug
          puts raw_output = HTTP.post(PAIRS_URL, :body => POST_PARAMS)
          output = JSON.parse(raw_output)
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
