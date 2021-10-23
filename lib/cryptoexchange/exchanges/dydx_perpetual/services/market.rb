module Cryptoexchange::Exchanges
  module DydxPerpetual
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::DydxPerpetual::Market::API_URL}/stats/markets"
        end

        def get_base(base)
          if base == "PBTC"
            return "BTC"
          end

          base
        end

        def adapt_all(output)
          output["markets"].map do |ticker, value|
            next if value["type"] != "PERPETUAL"

            base, target = ticker.split('-')
            converted_base = get_base(base)

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: converted_base,
              target: target,
              contract_interval: "perpetual",
              inst_id: value["symbol"],
              market: DydxPerpetual::Market::NAME
            )
            adapt(value, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = DydxPerpetual::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['baseVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id    = market_pair.inst_id
          ticker
        end
      end
    end
  end
end
