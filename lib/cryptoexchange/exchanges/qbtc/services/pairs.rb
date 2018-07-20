module Cryptoexchange::Exchanges
  module Qbtc
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Qbtc::Market::API_URL}/getAllCoinInfo.do"

        def fetch
          output = super
          adapt(output['result'])
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base, target = pair['symbol'].split('_')
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Qbtc::Market::NAME
                            )
          end
          market_pairs
        end
      end
    end
  end
end
