module Cryptoexchange::Exchanges
  module Cryptobulls
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Cryptobulls::Market::API_URL}/ticker"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.collect do |pair, _ticker|
            target_matcher = /\A(ETH|BTC|USDT)/i.match(pair).to_s

            base   = pair.sub(target_matcher, '')
            target = target_matcher
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Cryptobulls::Market::NAME
            )
          end
        end
      end
    end
  end
end
