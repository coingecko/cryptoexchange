module Cryptoexchange::Exchanges
  module Jex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(self.ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Jex::Market::API_URL}"
        end

        def adapt_all(output)
          market_pairs = []
          output.map do |pair, ticker|
            separator = /( CALL | PUT |ETF)/ =~ pair
            unless !separator.nil?
              base, target = pair.split('/')
              market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base.upcase,
                target: target.upcase,
                market: Jex::Market::NAME
              )

              adapt(ticker, market_pair)
            end
          end
        end

        def adapt(output, market_pair)
          ticker            = Cryptoexchange::Models::Ticker.new
          ticker.base       = market_pair.base
          ticker.target     = market_pair.target
          ticker.market     = Jex::Market::NAME
          ticker.last       = NumericHelper.to_d(output['last'])
          ticker.bid        = NumericHelper.to_d(output['highestBid'])
          ticker.ask        = NumericHelper.to_d(output['lowestAsk'])
          ticker.change     = NumericHelper.to_d(output['percentChange'])*100
          ticker.high       = NumericHelper.to_d(output['high24hr'])
          ticker.low        = NumericHelper.to_d(output['low24hr'])
          ticker.volume     = NumericHelper.to_d(output['baseVolume'])
          ticker.timestamp  = DateTime.now.to_time.to_i
          ticker.payload    = output
          ticker
        end

      end
    end
  end
end
