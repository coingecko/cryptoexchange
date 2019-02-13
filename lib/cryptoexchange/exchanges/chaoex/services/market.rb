module Cryptoexchange::Exchanges
  module Chaoex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          pairs = Cryptoexchange::Exchanges::Chaoex::Services::Pairs.new.fetch
          pair = pairs.select { |pair| pair.base == market_pair.base && pair.target == market_pair.target }.first
          output = super(ticker_url(pair))
          adapt(output, market_pair)
        end

        def ticker_url(pair)
          base_id, target_id = pair.inst_id.split("-")
          "#{Cryptoexchange::Exchanges::Chaoex::Market::API_URL}/quote/realTime?baseCurrencyId=#{target_id}&tradeCurrencyId=#{base_id}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          market = output['attachment']

          ticker.base   = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Chaoex::Market::NAME
          ticker.last   = NumericHelper.to_d(market['last'])
          ticker.high   = NumericHelper.to_d(market['high'])
          ticker.low    = NumericHelper.to_d(market['low'])
          ticker.ask    = NumericHelper.to_d(market['sell'])
          ticker.bid    = NumericHelper.to_d(market['buy'])
          ticker.volume = NumericHelper.divide(NumericHelper.to_d(market['vol']), ticker.last)
          ticker.timestamp = nil
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
