module Cryptoexchange::Exchanges
  module MercadoNiobioCash
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::MercadoBitcoin::Market::API_URL}"
        end
        
                def adapt_all(output)
          output['data'].map do |target, ticker|
            base = target
            target = BRL
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: MercadoNiobioCash::Market::NAME
                          )
            adapt(ticker, market_pair, output['data']['date'])
          end
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
          ticker.volume    = NumericHelper.to_d(ticker_json['NBR']) #Volume is the base currency, in this case, NBR
          ticker.timestamp = ticker_json['date']
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
