module Cryptoexchange::Exchanges
  module BitmartFutures
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          output = output['data']['tickers']
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BitmartFutures::Market::API_URL}/ifcontract/tickers"
        end

        def adapt(output, market_pair)
          output = output.find { |t| t['contract_id'] == market_pair.inst_id }
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id = market_pair.inst_id
          ticker.market = BitmartFutures::Market::NAME
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id = market_pair.inst_id
          ticker.last = NumericHelper.to_d(output['last_price'])
          ticker.high = NumericHelper.to_d(output['high'])
          ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.divide(NumericHelper.to_d(output['amount24']), ticker.last)
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
