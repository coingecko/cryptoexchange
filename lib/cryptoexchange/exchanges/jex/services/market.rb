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
          market_pairs = {}
          output.each do |pair|
            if !derivative(pair[0])
            market_pairs[pair[0]] = pair[1]
            end
          end
          market_pairs.map do |pair, ticker|
            base, target = pair.split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base.upcase,
              target: target.upcase,
              market: Jex::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def derivative(pair)
          etf = /(ETF)/ =~ pair
          option = /( PUT | CALL)/ =~ pair
          if etf && !pair.include?("/")
            true  
          elsif option && pair.count("/") > 1
            true
          else
            false
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
          ticker.timestamp  = nil
          ticker.payload    = output
          ticker
        end

      end
    end
  end
end
