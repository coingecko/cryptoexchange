module Cryptoexchange::Exchanges
  module Fmex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output['data'], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Fmex::Market::API_URL}/market/ticker/#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Fmex::Market::NAME
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id = market_pair.inst_id
          ticker.ask = NumericHelper.to_d(output['ticker'][4])
          ticker.bid = NumericHelper.to_d(output['ticker'][2])
          ticker.last = NumericHelper.to_d(output['ticker'][0])
          ticker.high = NumericHelper.to_d(output['ticker'][7])
          ticker.low = NumericHelper.to_d(output['ticker'][8])
          ticker.volume = NumericHelper.divide(NumericHelper.to_d(output['ticker'][9]), ticker.last)
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
