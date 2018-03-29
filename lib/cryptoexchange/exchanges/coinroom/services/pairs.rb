module Cryptoexchange::Exchanges
  module Coinroom
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinroom::Market::API_URL}/availableCurrencies"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          fiat_currency, crypto_currency = output["real"], output["crypto"]
          market_pairs = []
          fiat_currency.each do |fiat|
            crypto_currency.each do |crypto|
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: crypto,
                                target: fiat,
                                market: Coinroom::Market::NAME
                              )
            end
          end
          market_pairs
        end
        
      end
    end
  end
end
