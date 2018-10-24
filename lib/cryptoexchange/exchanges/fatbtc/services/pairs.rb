module Cryptoexchange::Exchanges
  module Fatbtc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Fatbtc::Market::API_URL}/allticker/1/"

        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            base, target = pair[1]['dspName'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Fatbtc::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
