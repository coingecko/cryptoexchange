module Cryptoexchange::Exchanges
  module Btcc
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          if market_pair.target == 'USD'
            "#{Cryptoexchange::Exchanges::Btcc::Market::API_URL_USD}/ticker?symbol=#{market_pair.base}#{market_pair.target}"
          else
            "#{Cryptoexchange::Exchanges::Btcc::Market::API_URL_CNY}/ticker?symbol=#{market_pair.base}#{market_pair.target}"
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Btcc::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ticker']['AskPrice'])
          ticker.bid       = NumericHelper.to_d(output['ticker']['BidPrice'])
          ticker.last      = NumericHelper.to_d(output['ticker']['Last'])
          ticker.high      = NumericHelper.to_d(output['ticker']['High'])
          ticker.low       = NumericHelper.to_d(output['ticker']['Low'])
          ticker.volume    = NumericHelper.to_d(output['ticker']['Volume'])
          ticker.timestamp = output['ticker']['Timestamp'].to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
