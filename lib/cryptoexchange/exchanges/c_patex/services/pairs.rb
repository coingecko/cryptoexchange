module Cryptoexchange::Exchanges
  module CPatex
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CPatex::Market::API_URL}/markets.json"

        def fetch
          output = super
          output.map do |pair|
            base, target = pair['name'].split('/')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: CPatex::Market::NAME
            )
          end
        end
      end
    end
  end
end
