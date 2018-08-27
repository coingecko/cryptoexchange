module Cryptoexchange::Exchanges
    module FourteenBit
      module Services
        class Pairs < Cryptoexchange::Services::Pairs
          
          PAIRS_URL = "#{Cryptoexchange::Exchanges::FourteenBit::Market::API_URL}"
  
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
                market: FourteenBit::Market::NAME
              )
            end
            market_pairs
          end
  
        end
      end
    end
  end