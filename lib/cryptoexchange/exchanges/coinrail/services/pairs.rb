module Cryptoexchange::Exchanges
  module Coinrail
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Coinrail::Market::TICKER_URL}"

        def fetch
          raw_output = super
          output = []
          raw_output.map do |market|
            if market[0] == "btc_market" || market[0] == "krw_market"
              market[1].each { |pair|
                output.push(pair)
              }
            end
          end
          adapt(output)
        end

        def adapt(output)
          pairs = []
          output.map do |pair|
            base = pair["ce_name"]
            target = pair["cs_name"]
            pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Coinrail::Market::NAME
                            )
          end
        pairs
        end
      end
    end
  end
end
