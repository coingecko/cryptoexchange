module Cryptoexchange::Exchanges
  module TrxMarket
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::TrxMarket::Market::API_URL}/dex/exchange/marketPair/list"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          pairs = []
          output['data']['rows'].each do |pair|
            pairs << Cryptoexchange::Models::MarketPair.new(
                base: pair["fShortName"],
                target: pair["sShortName"],
                inst_id: pair['id'],
                market: TrxMarket::Market::NAME
              )
          end
          pairs
        end
      end
    end
  end
end
