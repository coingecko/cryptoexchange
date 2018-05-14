module Cryptoexchange::Exchanges
  module Heat
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Heat::Market::API_URL}/exchange/markets/all/change/true/0/1/0/100"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|

            market_pairs << Cryptoexchange::Models::MarketPair.new(
              # if pair["assetProperties"] or pair["currencyProperties"] does not exist for either base or target, it means the asset / currency = 'HEAT'
                              base: pair["assetProperties"] ? pair["assetProperties"].split(",")[0].delete("[").tr('"','') : "HEAT",
                              target: pair["currencyProperties"] ? pair["currencyProperties"].split(",")[0].delete("[").tr('"','') : "HEAT",
                              market: Heat::Market::NAME
                            )
          end

          market_pairs
        end
      end
    end
  end
end
