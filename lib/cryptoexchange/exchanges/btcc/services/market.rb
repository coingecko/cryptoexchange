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
          ticker = Btcc::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Btcc::Market::NAME
          ticker.ask = output['ticker']['AskPrice']
          ticker.bid = output['ticker']['BidPrice']
          ticker.last = output['ticker']['Last']
          ticker.high = output['ticker']['High']
          ticker.low = output['ticker']['Low']
          ticker.volume = output['ticker']['Volume']
          ticker.timestamp = output['ticker']['Timestamp']
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
