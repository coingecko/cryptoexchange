module Cryptoexchange::Exchanges
  module Indoex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Indoex::Market::API_URL}/getMarketDetails"

        def fetch
          output = super
          output['marketdetails'].map do |pair|
            base, target = pair["pair"].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Indoex::Market::NAME
            )
          end
        end
      end
    end
  end
end
