module Cryptoexchange::Exchanges
  module BhexFutures
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
          "#{Cryptoexchange::Exchanges::BhexFutures::Market::API_URL}/contract/ticker/24hr"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker["symbol"].split("-") 
            next if ticker["symbol"].include?("USDT") || ticker["symbol"].include?("PERP")
            target = "USDT"
            
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            inst_id: ticker["symbol"],
                            contract_interval: "perpetual",
                            market: BhexFutures::Market::NAME
                          )

            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BhexFutures::Market::NAME
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id   = market_pair.inst_id
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.high      = NumericHelper.to_d(output['highPrice'])
          ticker.low       = NumericHelper.to_d(output['lowPrice'])
          ticker.volume    = NumericHelper.flip_volume(NumericHelper.to_d(output['volume']), ticker.last)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
