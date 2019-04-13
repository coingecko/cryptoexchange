module Cryptoexchange::Exchanges
  module Blokmy
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Blokmy::Market::API_URL}/tickers.json"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _ticker|
            base, target = pair.split(/(BTC$)+|(MYR$)+/i)
            Cryptoexchange::Models::MarketPair.new(
            base: base,
            target: target,
            market: Blokmy::Market::NAME
            )
          end
        end
      end
    end
  end
end
