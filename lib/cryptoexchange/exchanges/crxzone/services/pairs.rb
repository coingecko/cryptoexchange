module Cryptoexchange::Exchanges
  module Crxzone
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Crxzone::Market::API_URL}/CurrencyPairs"
        CURRENCY_IDS = []

        def fetch
          output = super
          adapt(output["Result"])
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair["PrimaryCurrencyCode"],
                              target: pair["SecondaryCurrencyCode"],
                              market: Crxzone::Market::NAME
                            )
           CURRENCY_IDS << {id: pair["ID"],
                            base: pair["PrimaryCurrencyCode"],
                            target: pair["SecondaryCurrencyCode"]
                          }
          end
          market_pairs
        end
      end
    end
  end
end
