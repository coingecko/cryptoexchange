module Cryptoexchange::Exchanges
  module MercadoNiobioCash
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
          "#{Cryptoexchange::Exchanges::MercadoBitcoin::Market::API_URL}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker_json      = output['asset']
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = MercadoNiobioCash::Market::NAME
          ticker.last      = NumericHelper.to_d(ticker_json['last'])
          ticker.high      = NumericHelper.to_d(ticker_json['high'])
          ticker.low       = NumericHelper.to_d(ticker_json['low'])
          ticker.volume    = NumericHelper.to_d(ticker_json['BRL'])
          ticker.timestamp = ticker_json['date']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
