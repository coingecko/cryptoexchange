module Cryptoexchange::Exchanges
  module Szzc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Szzc::Market::API_URL}/trading_pairs"


        def fetch
          adapt(super)
        end

        def adapt(output)
          market_pairs = []
          HashHelper.dig(output, 'status', 'message').each do |name, pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair['bid_asset_symbol'],
                              target: pair['ask_asset_symbol'],
                              market: Szzc::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
