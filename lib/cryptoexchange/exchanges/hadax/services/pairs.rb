module Cryptoexchange::Exchanges
  module Hadax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Hadax::Market::PAIRS_API_URL}"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data'].map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['base-currency'],
              target: pair['quote-currency'],
              market: Hadax::Market::NAME
            )
          end
        end
      end
    end
  end
end
