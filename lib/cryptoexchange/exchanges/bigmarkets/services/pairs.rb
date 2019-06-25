module Cryptoexchange::Exchanges
  module Bigmarkets
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bigmarkets::Market::API_URL}/tickers"

        def fetch
          output = super
          market_pairs = []
          output['combinations'].each do |pair|
            base, target = pair['pair'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Bigmarkets::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
