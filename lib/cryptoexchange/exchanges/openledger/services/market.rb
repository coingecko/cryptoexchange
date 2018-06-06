module Cryptoexchange::Exchanges
  module Openledger
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
          base   = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Openledger::Market::API_URL}/ticker?market=#{base}_#{target}"
        end

        def adapt(output, market_pair)
          data = output['result']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Openledger::Market::NAME
          ticker.ask       = NumericHelper.to_d(data['Ask'])
          ticker.bid       = NumericHelper.to_d(data['Bid'])
          ticker.last      = NumericHelper.to_d(data['Last'])
          ticker.high      = NumericHelper.to_d(data['High'])
          ticker.low       = NumericHelper.to_d(data['Low'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(data['BaseVolume']), ticker.last)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end

      end
    end
  end
end
