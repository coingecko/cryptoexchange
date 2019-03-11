module Cryptoexchange::Exchanges
  module Nexybit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Nexybit::Market::API_URL}/symbols"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['spotCodeBatchD'].map do |_key, pairs|
            pairs.map do |_key, pair|
              Cryptoexchange::Models::MarketPair.new(
                base:   pair['trade_currency'],
                target: pair['reference_currency'],
                market: Nexybit::Market::NAME
              )
            end
          end.flatten
        end
      end
    end
  end
end
