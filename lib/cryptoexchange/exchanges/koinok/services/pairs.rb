module Cryptoexchange::Exchanges
  module Koinok
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Koinok::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |output|
            base, target = output['marketSymbol'].split("-")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Koinok::Market::NAME
            )
          end
        end
      end
    end
  end
end
