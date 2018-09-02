module Cryptoexchange::Exchanges
  module Bitmart
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitmart::Market::API_URL}/tickers/market_cap"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |value|
            base, target = value['pair'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                    base: base,
                    target: target,
                    inst_id: value['symbolId'],
                    market: Bitmart::Market::NAME
                  )
          end

          market_pairs
        end
      end
    end
  end
end
