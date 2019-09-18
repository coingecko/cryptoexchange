module Cryptoexchange::Exchanges
  module GateFutures
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
          "#{Cryptoexchange::Exchanges::GateFutures::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker["contract"].split("_")
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: GateFutures::Market::NAME,
                            inst_id: ticker["contract"]
                          )
            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = GateFutures::Market::NAME
          ticker.inst_id = market_pair.inst_id
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.high = NumericHelper.to_d(output['high_24h'])
          ticker.low = NumericHelper.to_d(output['low_24h'])
          ticker.volume = NumericHelper.divide(output['volume_24h_usd'].to_f, ticker.last)
          
          ticker.start_timestamp = nil
          ticker.expire_timestamp = nil

          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
