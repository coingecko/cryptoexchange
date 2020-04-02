module Cryptoexchange::Exchanges
  module LiquidDerivatives
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
          "#{Cryptoexchange::Exchanges::LiquidDerivatives::Market::API_URL}/products?perpetual=1"
        end

        def adapt_all(output)
          output.map do |output|
            base = output["base_currency"].split("-")[1]
            target = output["quoted_currency"]

            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            inst_id: output["currency_pair_code"],
                            contract_interval: output["product_type"].downcase,
                            market: LiquidDerivatives::Market::NAME
                          )

            adapt(output, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.inst_id   = market_pair.inst_id
          ticker.contract_interval = market_pair.contract_interval
          ticker.market    = LiquidDerivatives::Market::NAME

          ticker.bid       = NumericHelper.to_d(output['low_market_bid'])
          ticker.ask       = NumericHelper.to_d(output['high_market_ask'])
          ticker.last      = NumericHelper.to_d(output['last_traded_price'])
          ticker.volume    = NumericHelper.to_d(output['volume_24h'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
