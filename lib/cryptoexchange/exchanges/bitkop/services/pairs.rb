module Cryptoexchange::Exchanges
  module Bitkop
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitkop::Market::API_URL}/tickerall"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            base, target = pair[1]['symbol'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Bitkop::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
