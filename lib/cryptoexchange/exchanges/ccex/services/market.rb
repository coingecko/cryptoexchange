module Cryptoexchange::Exchanges
  module Ccex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          ticker_output  = super(ticker_url(market_pair))
          volume_output = super(volume_url(market_pair))
          adapt(ticker_output, volume_output, market_pair)
        end

        def ticker_url(market_pair)
          name = "#{market_pair.base}-#{market_pair.target}".downcase
          "#{Cryptoexchange::Exchanges::Ccex::Market::API_URL}/#{name}.json"
        end

        def volume_url(market_pair)
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Ccex::Market::API_URL}/volume_#{target}.json"
        end

        def adapt(ticker_output, volumes_output, market_pair)
          market = ticker_output['ticker']
          volume = HashHelper.dig(volumes_output, 'ticker', market_pair.base.downcase, 'vol')

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Ccex::Market::NAME
          ticker.last      = NumericHelper.to_d(market['lastprice'])
          ticker.bid       = NumericHelper.to_d(market['lastbuy'])
          ticker.ask       = NumericHelper.to_d(market['lastsell'])
          ticker.high      = NumericHelper.to_d(market['high'])
          ticker.low       = NumericHelper.to_d(market['low'])
          ticker.volume    = volume ? NumericHelper.to_d(volume)/ticker.last : 0
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
