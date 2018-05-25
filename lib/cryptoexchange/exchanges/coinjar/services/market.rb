module Cryptoexchange::Exchanges
  module Coinjar
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
          "#{Cryptoexchange::Exchanges::Coinjar::Market::API_URL}/#{market_pair.base.upcase}#{market_pair.target.upcase}/ticker"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinjar::Market::NAME

          ticker.volume    = NumericHelper.to_d(output['volume'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])

          ticker.timestamp = DateTime.rfc3339(output['transition_time']).to_time.to_i
          ticker.payload   = output
          ticker
        end

      end
    end
  end
end
