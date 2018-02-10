module Cryptoexchange::Exchanges
  module Rightbtc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Rightbtc::Market::API_URL}/trading_pairs"
        def fetch
          output = super
          adapt(output)
        end
        
        def adapt(output)
          markets = output['status']['message']
          markets.map do |pair|
            Cryptoexchange::Models::MarketPair.new(
              base: pair[1]['bid_asset_symbol'],
              target: pair[1]['ask_asset_symbol'],
              market: Rightbtc::Market::NAME
            )
          end
        end
      end
    end
  end
end
