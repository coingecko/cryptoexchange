module Cryptoexchange::Exchanges
  module Coin2001
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
          "#{Cryptoexchange::Exchanges::Coin2001::Market::API_URL}/v1/public/getMarketSummaries"
        end

        def adapt_all(output)
          output['result'].map do |ticker|
            target, base = ticker['MarketName'].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coin2001::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coin2001::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['Bid'])
          ticker.ask       = NumericHelper.to_d(output['Ask'])
          ticker.last      = NumericHelper.to_d(output['Last'])
          ticker.volume    = NumericHelper.to_d(output['Volume'])
          ticker.high      = NumericHelper.to_d(output['High'])
          ticker.low       = NumericHelper.to_d(output['Low'])
          ticker.change    = NumericHelper.to_d(output['percentChange'])
          ticker.timestamp = Time.parse(output['TimeStamp']).to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
