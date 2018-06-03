module Cryptoexchange::Exchanges
  module Cybex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL   = "#{Cryptoexchange::Exchanges::Cybex::Market::API_URL}"
        HTTP_METHOD = 'POST'
        POST_PARAMS = { "jsonrpc": "2.0", "method": "list_assets", "params": ["A", 100], "id": 1 }

        def fetch
          output    = super
          pair_list = list_all_combinations(output)
          adapt(pair_list)
        end

        def list_all_combinations(output)
          assets = output['result'].map { |asset| asset['symbol'] }
          assets.combination(2).to_a
        end

        def adapt(pair_list)
          pair_list.map do |pair|
            target, base = pair
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Cybex::Market::NAME
            )
          end
        end
      end
    end
  end
end
