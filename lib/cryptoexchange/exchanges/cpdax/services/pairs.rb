module Cryptoexchange::Exchanges
  module Cpdax
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cpdax::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['data']['tickerList'].map do |ticker|
            base, target = ticker['currency_pair'].split("-")
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Cpdax::Market::NAME
            )
          end
        end
      end
    end
  end
end
