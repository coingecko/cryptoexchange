module Cryptoexchange::Exchanges
  module Biztranex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Biztranex::Market::API_URL}/getmarkets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['result']
          pairs.map do |pair|
            next unless pair['IsActive']
            Cryptoexchange::Models::MarketPair.new(
              base:   pair['MarketCurrency'],
              target: pair['BaseCurrency'],
              market: Biztranex::Market::NAME
            )
          end
        end
      end
    end
  end
end
