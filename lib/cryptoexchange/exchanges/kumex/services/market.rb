module Cryptoexchange::Exchanges
  module Kumex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          volume = JSON.parse(HTTP.get(volume_url))
          adapt(output, market_pair, volume)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Kumex::Market::API_URL}/ticker?symbol=#{market_pair.inst_id}"
        end

        def volume_url
          "https://kitchen.kumex.com/kumex-trade/market/all"
        end

        def adapt(output, market_pair, volume)
          output = output['data']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Kumex::Market::NAME
          ticker.inst_id    = output['symbol']

          ticker.last      = NumericHelper.to_d(output['price'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(volume['data']['volume'].to_f), ticker.last)
          ticker.bid       = NumericHelper.to_d(output['bestBidPrice'])
          ticker.ask       = NumericHelper.to_d(output['bestAskPrice'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
