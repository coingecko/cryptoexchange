module Cryptoexchange::Exchanges
  module Bitubu
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitubu::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |output|
            base, target = output['name'].split('/')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitubu::Market::NAME
            )
          end
        end
      end
    end
  end
end
