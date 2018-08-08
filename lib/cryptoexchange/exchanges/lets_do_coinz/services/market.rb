module Cryptoexchange::Exchanges
  module LetsDoCoinz
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          response = super(ticker_url)
          adapt_all(response)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::LetsDoCoinz::Market::API_URL}/public/ticker"
        end

        def adapt_all(response)
          response.map do |record|
            base, target = record['pair'].split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: LetsDoCoinz::Market::NAME
            )
            adapt(record, market_pair)
          end        
        end

        def adapt(record, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = LetsDoCoinz::Market::NAME
          ticker.low       = NumericHelper.to_d(record['price_min'])
          ticker.high      = NumericHelper.to_d(record['price_max'])
          ticker.last      = NumericHelper.to_d(record['last'])
          ticker.bid       = NumericHelper.to_d(record['bid'])
          ticker.ask       = NumericHelper.to_d(record['ask'])         
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(record['volume']), ticker.last)
          ticker.timestamp = DateTime.parse(record['timestamp']).to_time.to_i
          ticker.payload   = record
          ticker
        end
      end
    end
  end
end
