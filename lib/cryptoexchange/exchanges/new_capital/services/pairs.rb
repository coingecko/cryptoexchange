module Cryptoexchange::Exchanges
  module NewCapital
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::NewCapital::Market::API_URL}/ticker"

        def fetch
          output = super
          market_pairs = []
          output.each do |pair|
            base, target = pair["symbol"].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: NewCapital::Market::NAME
            )
          end
          market_pairs
        end

      end
    end
  end
end
