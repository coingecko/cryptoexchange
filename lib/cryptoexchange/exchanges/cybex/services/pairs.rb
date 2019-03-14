require 'pry'
module Cryptoexchange::Exchanges
  module Cybex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL           = "https://app.cybex.io/lab/exchange/asset".freeze
        # HTTP_METHOD         = 'POST'
        # POST_PARAMS         = { "jsonrpc": "2.0", "method": "list_assets", "params": ["A", 100], "id": 1 }
        # OMITTED_SYMBOLS     = ['ANGEL', 'JADE', 'JAMES']
        # MAIN_TARGET_SYMBOLS = ['USDT', 'BTC', 'ETH', 'CYB']


        def fetch
          output    = super
          pair_list = list_all_combinations(output)
          adapt(pair_list)
        end

        def list_all_combinations(output)
          pairs_list = []
          output.each do |base, targets|
            formatted_base = [base.gsub("JADE.", "")]
            formatted_targets = targets.map { |target|  target.gsub("JADE.", "") }
            raw_pairs = formatted_base.product(formatted_targets)
            raw_pairs.each do |raw_pair|
              pairs_list << raw_pair
            end
          end
          pairs_list
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
