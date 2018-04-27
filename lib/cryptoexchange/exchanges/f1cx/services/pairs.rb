module Cryptoexchange::Exchanges
  module F1cx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::F1cx::Market::API_URL}/markets"

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
              market: F1cx::Market::NAME
            )
          end  
        end
      end
    end
  end
end
