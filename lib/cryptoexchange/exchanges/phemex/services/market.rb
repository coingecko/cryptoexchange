module Cryptoexchange::Exchanges
  module Phemex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Phemex::Market::API_URL}/ticker/24hr/all"
        end

        def adapt_all(output)
          output["result"].map do |output|
            base, target = Phemex::Market.separate_symbol(output["symbol"])

            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            inst_id: output["symbol"],
                            contract_interval: "perpetual",
                            market: Phemex::Market::NAME
                          )

            adapt(market_pair, output)
          end.compact
        end

        def adapt(market_pair, output)
          ticker                   = Cryptoexchange::Models::Ticker.new
          ticker.base              = market_pair.base
          ticker.target            = market_pair.target
          ticker.inst_id           = market_pair.inst_id
          ticker.contract_interval = market_pair.contract_interval
          ticker.market            = Phemex::Market::NAME

          ticker.last              = NumericHelper.divide(NumericHelper.to_d(output['lastEp']), 10000)
          ticker.volume            = NumericHelper.divide(NumericHelper.to_d(output['volume']), ticker.last)
          ticker.ask               = NumericHelper.divide(NumericHelper.to_d(output['askEp']), 10000)
          ticker.bid               = NumericHelper.divide(NumericHelper.to_d(output['bidEp']), 10000)
          ticker.high              = NumericHelper.divide(NumericHelper.to_d(output['highEp']), 10000)
          ticker.low               = NumericHelper.divide(NumericHelper.to_d(output['lowEp']), 10000)

          ticker.timestamp         = nil
          ticker.payload           = output
          ticker
        end
      end
    end
  end
end
