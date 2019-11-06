module Cryptoexchange::Exchanges
  module Bakkt
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
          "#{Cryptoexchange::Exchanges::Bakkt::Market::API_URL}/DelayedMarkets.shtml?getContractsAsJson=&productId=23808&hubId=26066"
        end

        def adapt_all(output)
          output.map do |ticker|
            pair = Cryptoexchange::Models::MarketPair.new(
                      base: "BTC",
                      target: "USD",
                      inst_id: ticker["marketId"].to_s,
                      market: Bakkt::Market::NAME,
                      contract_interval: ticker["marketStrip"]
                    )
            adapt(ticker, pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bakkt::Market::NAME
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id = market_pair.inst_id
          ticker.last = NumericHelper.to_d(output['lastPrice'])
          ticker.volume = NumericHelper.to_d(output['volume'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
