module Cryptoexchange::Exchanges
  module Cashpayz
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cashpayz::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["Data"].map do |pair, ticker|
            target, base = pair.split('_')
            Cryptoexchange::Models::MarketPair.new({
              base: base,
              target: target,
              market: Cashpayz::Market::NAME
            })
          end
        end
      end
    end
  end
end
