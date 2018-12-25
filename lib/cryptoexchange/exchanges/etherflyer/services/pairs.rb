module Cryptoexchange::Exchanges
  module Etherflyer
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Etherflyer::Market::API_URL}/market/allticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output['ticker'].each do |ticker|
            base, target = ticker["symbol"].split("_")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Etherflyer::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
