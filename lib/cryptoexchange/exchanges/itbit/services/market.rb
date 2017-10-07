module Cryptoexchange::Exchanges
  module Itbit
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
          "#{Cryptoexchange::Exchanges::Itbit::Market::API_URL}/markets/#{market_pair.base}#{market_pair.target}/ticker"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Itbit::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.last      = NumericHelper.to_d(output['lastPrice'])
          ticker.high      = NumericHelper.to_d(output['high24h'])
          ticker.low       = NumericHelper.to_d(output['low24h'])
          ticker.volume    = NumericHelper.to_d(output['volume24h'])
          ticker.timestamp = DateTime.strptime(output['serverTimeUTC'],'%FT%T').to_time.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
