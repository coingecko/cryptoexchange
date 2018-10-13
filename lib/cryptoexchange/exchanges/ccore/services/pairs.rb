module Cryptoexchange::Exchanges
  module Ccore
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ccore::Market::API_URL}/integration/dailyhistory?partnerId=2"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair[0].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Ccore::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
