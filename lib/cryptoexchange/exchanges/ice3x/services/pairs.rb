module Cryptoexchange::Exchanges
  module Ice3x
    module Services
      require 'byebug'
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Ice3x::Market::API_URL}/stats/marketdepthbtcav"

        def fetch
          byebug
          output = super
          market_pairs = []
          output['response']['entities'][0].each do |pair|
            pair = pair.split('\/')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Ice3x::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
