module Cryptoexchange::Exchanges
  module Kraken
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
          base = market_pair.base
          target = market_pair.target
          "#{Cryptoexchange::Exchanges::Kraken::Market::API_URL}/Ticker?pair=#{base}#{target}"
        end

        def adapt(output, market_pair)
          output = output['result'].values.first

          vol24h = output['v'].last
          high24h = output['h'].last
          low24h = output['l'].last

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Kraken::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['a'].first)
          ticker.bid       = NumericHelper.to_d(output['b'].first)
          ticker.last      = NumericHelper.to_d(output['c'].first)
          ticker.high      = NumericHelper.to_d(high24h)
          ticker.low       = NumericHelper.to_d(low24h)
          ticker.volume    = NumericHelper.to_d(vol24h)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
