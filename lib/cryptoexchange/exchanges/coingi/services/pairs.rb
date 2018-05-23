module Cryptoexchange::Exchanges
  module Coingi
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coingi::Market::API_URL}/current/24hour-rolling-aggregation"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base = HashHelper.dig(pair, 'currencyPair', 'base')
            target = HashHelper.dig(pair, 'currencyPair', 'counter')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coingi::Market::NAME
            )
          end
        end
      end
    end
  end
end
