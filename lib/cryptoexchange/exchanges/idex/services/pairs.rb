module Cryptoexchange::Exchanges
  module Idex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Idex::Market::API_URL}/returnTicker"
        HTTP_METHOD = 'POST'

        def fetch
          output = super
          pair_list = filter_nil_pair(output)
          adapt(pair_list)
        end

        def filter_nil_pair(output)
          pair_list = []
          output.map do |k, v|
            i = 0
            v.select do |key, value|
              i += 1 if value == "N/A"
            end
            next if i >= 5
            pair_list << k
          end
          pair_list
        end

        def adapt(pair_list)
          pair_list.map do |pair|
            target, base = pair.split("_")
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Idex::Market::NAME
            )
          end
        end
      end
    end
  end
end
