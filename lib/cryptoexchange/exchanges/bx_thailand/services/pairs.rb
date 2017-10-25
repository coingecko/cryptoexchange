module Cryptoexchange::Exchanges
  module BxThailand
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BxThailand::Market::API_URL}"


        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.values.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair['secondary_currency'],
              target: pair['primary_currency'],
              market: BxThailand::Market::NAME
            )
          end
        end
      end
    end
  end
end
