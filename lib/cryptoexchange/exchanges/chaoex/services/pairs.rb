module Cryptoexchange::Exchanges
  module Chaoex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Chaoex::Market::API_URL}/coin/allCurrencyRelations"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = output['attachment']
          pairs.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base:      pair['tradeCurrencyNameEn'],
              target:    pair['baseCurrencyNameEn'],
              market:    Chaoex::Market::NAME,
              inst_id:   "#{pair['tradeCurrencyId']}-#{pair['baseCurrencyId']}"
            )
          end
        end
      end
    end
  end
end
