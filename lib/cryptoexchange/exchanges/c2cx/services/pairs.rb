module Cryptoexchange::Exchanges
  module C2cx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        
        PAIRS_URL = "#{Cryptoexchange::Exchanges::C2cx::Market::API_URL}/ExchangePolicy"

        def fetch
          response = super
          adapt(response)
        end

        def adapt(response)
          market_pairs = []
          response['data']['SupportPairs'].each do |pair|
            target, base = pair.split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: C2cx::Market::NAME
            )
          end
          market_pairs
        end

      end
    end
  end
end