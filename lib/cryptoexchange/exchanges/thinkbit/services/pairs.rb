module Cryptoexchange::Exchanges
  module Thinkbit
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Thinkbit::Market::API_URL}/market/ticker"
        
        def fetch
          output = super
          market_pairs = []
          output['data'].each do |pair|
            base, target = pair['pair'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Thinkbit::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
