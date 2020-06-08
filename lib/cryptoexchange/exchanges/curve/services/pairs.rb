module Cryptoexchange::Exchanges
  module Curve
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        def pairs_url
          "https://api.blocklytics.org/pools/v1/pairs?platform=Curve&key=#{Cryptoexchange::Exchanges::Curve::Market.api_key}"
        end

        def fetch
          output = fetch_via_api(pairs_url)
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base, target = pair["pair"].split("-")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Curve::Market::NAME,
                            )
          end
          market_pairs
        end
      end
    end
  end
end
