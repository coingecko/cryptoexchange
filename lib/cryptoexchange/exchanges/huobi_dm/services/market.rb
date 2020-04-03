module Cryptoexchange::Exchanges
  module HuobiDm
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = if market_pair.contract_interval == "perpetual"
            super("#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/swap-ex/market/detail/merged?contract_code=#{market_pair.inst_id}")
          else
            super("#{Cryptoexchange::Exchanges::HuobiDm::Market::API_URL}/market/detail/merged?symbol=#{market_pair.inst_id}")
          end
          adapt(output, market_pair)
        end

        def adapt(output, market_pair)
          market = output['tick']

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.contract_interval    = market_pair.contract_interval
          ticker.inst_id   = market_pair.inst_id
          ticker.market    = HuobiDm::Market::NAME
          ticker.last      = NumericHelper.to_d(market['close'])
          ticker.bid       = NumericHelper.to_d(market['bid'][0]) if market['bid']
          ticker.ask       = NumericHelper.to_d(market['ask'][0]) if market['ask']
          ticker.high      = NumericHelper.to_d(market['high'])
          ticker.low       = NumericHelper.to_d(market['low'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(market['amount']), 2.0) # Divide by 2 as it is double counted
          ticker.timestamp = nil
          ticker.payload   = market
          ticker
        end
      end
    end
  end
end
