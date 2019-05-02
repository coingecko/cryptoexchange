module Cryptoexchange::Exchanges
  module Bitalong
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitalong::Market::API_URL}/index/pairs"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair.split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base.upcase,
                              target: target.upcase,
                              market: Bitalong::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
