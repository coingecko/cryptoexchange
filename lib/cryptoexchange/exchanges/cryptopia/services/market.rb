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
          handle_invalid(output)
          data = output['Data']
          base, target = data['Label'].split('/')

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = base
          ticker.target    = target
          ticker.market    = Cryptopia::Market::NAME
          ticker.last      = NumericHelper.to_d(data['LastPrice'])
          ticker.bid       = NumericHelper.to_d(data['BidPrice'])
          ticker.ask       = NumericHelper.to_d(data['AskPrice'])
          ticker.high      = NumericHelper.to_d(data['High'])
          ticker.low       = NumericHelper.to_d(data['Low'])
          ticker.volume    = NumericHelper.to_d(data['Volume'])
          ticker.change    = NumericHelper.to_d(data['Change'])
          ticker.timestamp = nil
          ticker.payload   = data
          ticker
        end

        def handle_invalid(output)
          if !output['Error'].nil?
            raise Cryptoexchange::ResultParseError, { response: output }
          end
        end
      end
    end
  end
end
