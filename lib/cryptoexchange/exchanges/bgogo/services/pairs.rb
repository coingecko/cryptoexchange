module Cryptoexchange::Exchanges
  module Bgogo
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL   = "#{Cryptoexchange::Exchanges::Bgogo::Market::API_URL}/tickers"

        def fetch
          output = Bgogo::Market.pairs_fetch(PAIRS_URL)
          adapt(output)
        end

        def adapt(output)
          output.map do |pair, _ticker|
            next if pair == 'status'
            base, target = pair.split('/')
            Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bgogo::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
