module Cryptoexchange::Exchanges
  module Coinone
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          "#{Cryptoexchange::Exchanges::Coinone::Market::API_URL}/ticker?currency=#{base}"
        end

        def adapt(output)
          ticker = Coinone::Models::Ticker.new
          ticker.base = output['currency']
          ticker.target = 'KRW'
          ticker.market = Coinone::Market::NAME
          ticker.last = output['last']
          ticker.high = output['high']
          ticker.low = output['low']
          ticker.volume = output['volume']
          ticker.timestamp = output['timestamp']
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
