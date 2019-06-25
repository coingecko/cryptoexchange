module Cryptoexchange::Exchanges
  module Bisq
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bisq::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, ticker|
            next if ticker.nil?
            base, target = pair.split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bisq::Market::NAME
              )
          end.compact
        end
      end
    end
  end
end
