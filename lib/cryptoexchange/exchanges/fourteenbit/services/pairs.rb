module Cryptoexchange::Exchanges
    module Fourteenbit
      module Services
        class Pairs < Cryptoexchange::Services::Pairs
          
          PAIRS_URL = "#{Cryptoexchange::Exchanges::Fourteenbit::Market::API_URL}"
  
          def fetch
            response = super
            adapt(response)
          end
  
          def adapt(response)
            market_pairs = []
            response.keys.each do |currency|
              target, base = response[currency], 'BTC'
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Fourteenbit::Market::NAME
              )
            end
            market_pairs
          end
  
        end
      end
    end
  end