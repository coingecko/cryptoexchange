module Cryptoexchange::Exchanges
  module MaxMaicoin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::MaxMaicoin::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            Cryptoexchange::Models::MarketPair.new(
                              base: output["base_unit"],
                              target: output["quote_unit"],
                              market: MaxMaicoin::Market::NAME
                            )
          end
        end
      end
    end
  end
end
