module Cryptoexchange::Exchanges
  module Myspeedtrade
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          ctx = OpenSSL::SSL::SSLContext.new
          ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
          output = HTTP.get(ticker_url(market_pair), ssl_context: ctx).parse(:json)
          adapt(market_pair, output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Myspeedtrade::Market::API_URL}/tickers/#{market_pair.base.downcase}#{market_pair.target.downcase}"
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Myspeedtrade::Market::NAME
          ticker.last = NumericHelper.to_d(output['ticker']['last'])
          ticker.bid = NumericHelper.to_d(output['ticker']['buy'])
          ticker.ask = NumericHelper.to_d(output['ticker']['sell'])
          ticker.high = NumericHelper.to_d(output['ticker']['high'])
          ticker.low = NumericHelper.to_d(output['ticker']['low'])
          ticker.volume = NumericHelper.to_d(output['ticker']['vol'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
