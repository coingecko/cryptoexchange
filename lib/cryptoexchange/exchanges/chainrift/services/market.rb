module Cryptoexchange::Exchanges
  module Chainrift
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output['data'])
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Chainrift::Market::API_URL}/Public/Market?"
        end


        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker['symbol'].split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Chainrift::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Chainrift::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.change    = NumericHelper.to_d(output['change'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = DateTime.parse(output['timestamp']).to_time.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
