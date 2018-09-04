module Cryptoexchange::Exchanges
  module Ice3x
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ice3x::Market::API_URL}/stats/marketdepthbtcav"

        def fetch
          output = super
          market_pairs = []
          output['response']['entities'].each do |pair|
            base, target = pair['pair_name'].split('/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              inst_id: pair['pair_id'],
                              market: Ice3x::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
