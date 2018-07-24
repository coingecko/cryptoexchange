module Cryptoexchange::Exchanges
  module Top100exchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Top100exchange::Market::API_URL}/ticker"
        
        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair['pair'].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Top100exchange::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
