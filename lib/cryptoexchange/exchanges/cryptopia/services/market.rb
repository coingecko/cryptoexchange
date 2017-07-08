module Cryptoexchange::Exchanges
  module Cryptopia
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
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Cryptopia::Market::API_URL}/GetMarket/#{base}_#{target}"
        end

        def adapt(output)
          data = output['Data']
          base, target = data['Label'].split('/')

          ticker = Cryptopia::Models::Ticker.new
          ticker.base = base
          ticker.target = target
          ticker.market = Cryptopia::Market::NAME
          ticker.last = data['LastPrice']
          ticker.bid = data['BidPrice']
          ticker.ask = data['AskPrice']
          ticker.high = data['High']
          ticker.low = data['Low']
          ticker.volume = data['Volume']
          ticker.change = data['Change']
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload = data
          ticker
        end
      end
    end
  end
end
