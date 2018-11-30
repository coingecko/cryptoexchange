module Cryptoexchange::Exchanges
  module Aphelion
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Aphelion::Market::API_URL}/ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            target, base = pair[0].split('-')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Aphelion::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
