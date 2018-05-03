module Cryptoexchange::Exchanges
  module Sistemkoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Sistemkoin::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output['data'].each do |based, pair|
            pair.each do |pair|
              market_pair = Cryptoexchange::Models::MarketPair.new(
                              base: pair['short_code'],
                              target: pair['currency'],
                              market: Sistemkoin::Market::NAME)              
              adapt(pair, market_pair)
            end
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Sistemkoin::Market::NAME
          ticker.last      = NumericHelper.to_d(output['current'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])  
          ticker.change    = NumericHelper.to_d(output['change_amount'])                    
          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.timestamp = Time.now.to_time.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
