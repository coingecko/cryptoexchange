module Cryptoexchange::Exchanges
  module Thecoin
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end
        
        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output['result'])
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Thecoin::Market::API_URL}/public/getmarketsummary?market=#{market_pair.base}-#{market_pair.target}&period=250"
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Thecoin::Market::NAME
          ticker.last      = NumericHelper.to_d(output['Last'].to_f)
          ticker.high      = NumericHelper.to_d(output['High'].to_f)
          ticker.low       = NumericHelper.to_d(output['Low'].to_f)
          ticker.bid       = NumericHelper.to_d(output['Bid'].to_f)
          ticker.ask       = NumericHelper.to_d(output['Ask'])
          ticker.volume    = NumericHelper.to_d(output['Volume'].to_f)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
