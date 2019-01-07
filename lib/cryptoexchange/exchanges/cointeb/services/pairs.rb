module Cryptoexchange::Exchanges
    module Cointeb
      module Services
        class Pairs < Cryptoexchange::Services::Pairs
          PAIRS_URL = "#{Cryptoexchange::Exchanges::Cointeb::Market::API_URL}/public/symbols"
  
  
          def fetch
            output = super
            adapt(output)
          end
  
          def adapt(output)
            market_pairs = []
            output['result'].each do |pair|
              pair_arr = pair.split('_')
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: pair_arr[0],
                                target: pair_arr[1],
                                market: Cointeb::Market::NAME
                              )
            end
            market_pairs
          end
        end
      end
    end
  end
  