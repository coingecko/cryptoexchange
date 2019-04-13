module Cryptoexchange::Exchanges
  module Bitbegin
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitbegin::Market::API_URL}/getmarkets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |pair|
            next unless pair['IsActive']
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['MarketCurrency'],
              target: pair['BaseCurrency'],
              market: Bitbegin::Market::NAME
            )
          end
        end
      end
    end
  end
end
