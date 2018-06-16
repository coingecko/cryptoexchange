module Cryptoexchange::Exchanges
  module Liqnet
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Liqnet::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            if pair['is_frozen'] == false
              base, target = pair['market'].split('/')
              market_pairs << Cryptoexchange::Models::MarketPair.new(
                                base: base,
                                target: target,
                                market: Liqnet::Market::NAME
                              )
             end
           end

          market_pairs
        end
      end
    end
  end
end
