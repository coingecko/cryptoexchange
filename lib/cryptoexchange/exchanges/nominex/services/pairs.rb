module Cryptoexchange::Exchanges
  module Nominex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Nominex::Market::API_URL}/pairs"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            base, target = output["name"].split('/')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Nominex::Market::NAME
            )
          end
        end
      end
    end
  end
end
