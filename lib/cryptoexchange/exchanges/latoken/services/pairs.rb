module Cryptoexchange::Exchanges
  module Latoken
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Latoken::Market::API_URL}/v1/coinmarketcap/ticker"


        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base, target = pair["ticker"].split("/")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Latoken::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
