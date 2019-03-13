module Cryptoexchange::Exchanges
  module Coinexmarket
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output['marketlist'])
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Coinexmarket::Market::API_URL}/marketlist"
        end


        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker['pair'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Coinexmarket::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinexmarket::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['min_sell'])
          ticker.bid       = NumericHelper.to_d(output['min_buy'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['24hrhigh'])
          ticker.volume    = NumericHelper.to_d(output['baseVolume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
