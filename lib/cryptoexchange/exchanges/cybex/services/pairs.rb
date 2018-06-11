module Cryptoexchange::Exchanges
  module Cybex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL           = "#{Cryptoexchange::Exchanges::Cybex::Market::API_URL}"
        HTTP_METHOD         = 'POST'
        POST_PARAMS         = { "jsonrpc": "2.0", "method": "list_assets", "params": ["A", 100], "id": 1 }
        OMITTED_SYMBOLS     = ['ANGEL', 'JADE', 'JAMES']
        MAIN_TARGET_SYMBOLS = ['USDT', 'BTC', 'ETH', 'CYB']


        def fetch
          output    = super
          pair_list = list_all_combinations(output)
          adapt(pair_list)
        end

        def list_all_combinations(output)
          pairs_list = []
          symbols    = output['result'].map { |asset| asset['symbol'] }
          symbols    = symbols - OMITTED_SYMBOLS
          symbols.delete_if { |sym| !/\A(#{Cryptoexchange::Exchanges::Cybex::Market::OMITTED_GATEWAY}\.)/.match(sym).nil? }
          symbols      = symbols.map { |a| a.split('.').last }
          symbol_pairs = symbols.product(MAIN_TARGET_SYMBOLS)
          symbol_pairs.map do |pair|
            next if pair[0] == pair[1] || pair[0] == 'USDT'
            next if /(BTC|ETH|CYB)/.match(pair[0]) && /(BTC|ETH|CYB)/.match(pair[1])
            pairs_list << pair
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
