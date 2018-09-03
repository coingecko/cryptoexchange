module Cryptoexchange::Exchanges
  module Bilaxy
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
          pairs = Cryptoexchange::Exchanges::Bilaxy::Services::Pairs.new.fetch
          pair = pairs.select { |p| p.base == market_pair.base && p.target == market_pair.target }.first
          id = pair.id
          "#{Cryptoexchange::Exchanges::Bilaxy::Market::API_URL}/ticker?symbol=#{id}"
        end

        def adapt(output, market_pair)
          data = output['data']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bilaxy::Market::NAME
          ticker.last      = NumericHelper.to_d(data['last'])
          ticker.ask       = NumericHelper.to_d(data['sell'])
          ticker.bid       = NumericHelper.to_d(data['buy'])
          ticker.low       = NumericHelper.to_d(data['low'])
          ticker.high      = NumericHelper.to_d(data['high'])
          ticker.volume    = NumericHelper.to_d(data['vol'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
