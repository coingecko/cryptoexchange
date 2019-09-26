module Cryptoexchange::Exchanges
  module CmeFutures
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
          "#{Cryptoexchange::Exchanges::CmeFutures::Market::API_URL}/CmeWS/mvc/Quotes/Future/8478/G?pageSize=500&_=1564549645686"
        end

        def adapt_all(output)
          output["quotes"].map do |ticker|
            pair = Cryptoexchange::Models::MarketPair.new(
                      base: ticker["productCode"],
                      target: "USD",
                      inst_id: ticker["quoteCode"],
                      market: CmeFutures::Market::NAME,
                      contract_interval: ticker["expirationMonth"]
                    )
            adapt(ticker, pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = CmeFutures::Market::NAME
          ticker.inst_id = market_pair.inst_id
          ticker.last = NumericHelper.to_d(output["last"])
          ticker.volume = NumericHelper.to_d(output["volume"]) * 5.0
          ticker.contract_interval = market_pair.contract_interval
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
