module Cryptoexchange::Exchanges
  module Satoexchange
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['market'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Satoexchange::Market::API_URL}/get_market_history/?market_id=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Satoexchange::Market::NAME
          ticker.ask = NumericHelper.to_d(output['ask'])
          ticker.bid = NumericHelper.to_d(output['bid'])
          ticker.last = NumericHelper.to_d(output['last_price'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.to_d(output['volume']) / ticker.last
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
