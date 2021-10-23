module Cryptoexchange::Exchanges
  module Bancor
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def pairs_url
          "#{Cryptoexchange::Exchanges::Bancor::Market::API_URL}/currencies/convertiblePairs"
        end

        def fetch
          output = fetch_via_api(pairs_url)
          adapt(output)
        end

        def adapt(output)
          pairs_ex_liquidity_pool = output['data'].select { |pair,_| !/BNT/.match?(pair) }

          pairs_ex_liquidity_pool.map do |base, target|
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bancor::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
