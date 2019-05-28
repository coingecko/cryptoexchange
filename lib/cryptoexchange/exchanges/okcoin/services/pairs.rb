module Cryptoexchange::Exchanges
  module Okcoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Okcoin::Market::API_URL}/instruments/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair|
            base, target = pair['instrument_id'].split("-")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Okcoin::Market::NAME
            )
          end
        end
      end
    end
  end
end
