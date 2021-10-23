module Cryptoexchange::Exchanges
  module Bitbox
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Bitbox::Market::API_URL}/market/public/currentTickValue?coinPair=#{market_pair.base.upcase}.#{market_pair.target.upcase}"
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bitbox::Market::NAME
          ticker.last = NumericHelper.to_d(output['responseData']['last'])
          ticker.low = NumericHelper.to_d(output['responseData']['low'])
          ticker.high = NumericHelper.to_d(output['responseData']['high'])
          ticker.bid = NumericHelper.to_d(output['responseData']['bid'])
          ticker.ask = NumericHelper.to_d(output['responseData']['ask'])
          ticker.volume = NumericHelper.to_d(output['responseData']['volume'] / ticker.last)
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
