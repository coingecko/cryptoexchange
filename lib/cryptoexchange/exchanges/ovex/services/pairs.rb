module Cryptoexchange::Exchanges
  module Ovex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ovex::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            Cryptoexchange::Models::MarketPair.new(
              base: output['name'].split('/').first,
              target: output['name'].split('/').last,
              market: Ovex::Market::NAME
            )
          end
        end
      end
    end
  end
end
