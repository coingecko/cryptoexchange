module Cryptoexchange::Exchanges
  module WhaleEx
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::WhaleEx::Market::API_URL}/allTickers"

        def fetch
          output = super
          output['ticker'].map do |pair|
            base, target = pair['symbol'].split('_')
            next if base.nil? || target.nil?

            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: WhaleEx::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
