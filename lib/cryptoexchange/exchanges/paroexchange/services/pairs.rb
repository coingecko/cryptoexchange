module Cryptoexchange::Exchanges
  module Paroexchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Paroexchange::Market::API_URL}/MarketCapTickerApi"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[0].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Paroexchange::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
