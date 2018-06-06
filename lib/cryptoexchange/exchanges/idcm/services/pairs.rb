module Cryptoexchange::Exchanges
  module Idcm
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Idcm::Market::API_URL}/RealTimeQuote/GetRealTimeQuotes"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['Data'].map do |pair|
            base, target = pair['TradePairCode'].split('/')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Idcm::Market::NAME
            )
          end
        end
      end
    end
  end
end
