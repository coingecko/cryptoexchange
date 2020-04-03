module Cryptoexchange::Exchanges
  module Hoo
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Hoo::Market::API_URL}/tickers/market"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output["data"].map do |output|
            base, target = output["symbol"].split('-')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Hoo::Market::NAME
            )
          end
        end
      end
    end
  end
end
