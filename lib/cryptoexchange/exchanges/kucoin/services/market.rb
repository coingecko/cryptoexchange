module Cryptoexchange::Exchanges
  module Kucoin
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
          "#{Cryptoexchange::Exchanges::Kucoin::Market::API_URL}/market/stats?symbol=#{market_pair.base.upcase}-#{market_pair.target.upcase}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker_json      = output['data']
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Kucoin::Market::NAME

          ticker.last      = NumericHelper.to_d(ticker_json['close'])
          ticker.high      = NumericHelper.to_d(ticker_json['high'])
          ticker.low       = NumericHelper.to_d(ticker_json['low'])
          ticker.volume    = NumericHelper.to_d(ticker_json['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
