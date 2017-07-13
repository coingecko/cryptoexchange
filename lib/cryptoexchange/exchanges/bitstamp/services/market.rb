module Cryptoexchange::Exchanges
  module Bitstamp
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
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Bitstamp::Market::API_URL}/#{base}#{target}"
        end

        def adapt(output, market_pair)
          ticker = Bitstamp::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bitstamp::Market::NAME
          ticker.ask = output['ask']
          ticker.bid = output['bid']
          ticker.last = output['last']
          ticker.high = output['high']
          ticker.low = output['low']
          ticker.volume = output['volume'].to_f
          ticker.timestamp = output['timestamp']
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
