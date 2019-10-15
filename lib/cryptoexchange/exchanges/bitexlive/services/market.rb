module Cryptoexchange::Exchanges
  module Bitexlive
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitexlive::Market::API_URL}/tickers?filter=#{market_pair.base.upcase}_#{market_pair.target.upcase}"
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitexlive::Market::NAME
          ticker.last      = NumericHelper.to_d(output[0]['LastPrice'])
          ticker.high      = NumericHelper.to_d(output[0]['high24h'])
          ticker.low       = NumericHelper.to_d(output[0]['low24h'])
          ticker.ask       = NumericHelper.to_d(output[0]['lowestAsk'])
          ticker.bid       = NumericHelper.to_d(output[0]['highestBid'])
          ticker.volume    = NumericHelper.to_d(output[0]['quoteVolume24h'])
          ticker.change    = NumericHelper.to_d(output[0]['percentChange'])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
