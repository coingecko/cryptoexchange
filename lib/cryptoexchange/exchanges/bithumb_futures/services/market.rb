module Cryptoexchange::Exchanges
  module BithumbFutures
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
          "#{Cryptoexchange::Exchanges::BithumbFutures::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output["data"].map do |output|
            base = output["symbol"].chomp("-PERP") 
            target = "USDT"

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              contract_interval: "perpetual",
              inst_id: output["symbol"],
              market: BithumbFutures::Market::NAME
            )

            adapt(output, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id   = market_pair.inst_id
          ticker.market    = BithumbFutures::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['bid'][0])
          ticker.ask       = NumericHelper.to_d(output['ask'][0])
          ticker.last      = NumericHelper.to_d(output['close'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
