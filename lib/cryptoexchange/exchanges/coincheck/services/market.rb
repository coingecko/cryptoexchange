module Cryptoexchange::Exchanges
  module Coincheck
    module Services
      class Market < Cryptoexchange::Services::Market
        def fetch(_)
          output = super(market_url(_))
          adapt(output)
        end

        def market_url(_)
          "#{Cryptoexchange::Exchanges::Coincheck::Market::API_URL}/ticker"
        end

        def adapt(output)
          ticker = Coincheck::Models::Ticker.new
          ticker.base = 'BTC'
          ticker.target = 'JPY'
          ticker.market = Coincheck::Market::NAME
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
