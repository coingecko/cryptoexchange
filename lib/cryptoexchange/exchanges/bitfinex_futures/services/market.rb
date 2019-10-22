module Cryptoexchange::Exchanges
  module BitfinexFutures
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BitfinexFutures::Market::API_URL}/tickers?symbols=#{market_pair.inst_id}"
        end

        def adapt(market_pair, output)
          output = output[0]
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.inst_id = market_pair.inst_id
          ticker.contract_interval = market_pair.contract_interval
          ticker.market = BitfinexFutures::Market::NAME
          ticker.ask = NumericHelper.to_d(output[3])
          ticker.bid = NumericHelper.to_d(output[1])
          ticker.last = NumericHelper.to_d(output[7])
          ticker.high = NumericHelper.to_d(output[9])
          ticker.low = NumericHelper.to_d(output[10])
          ticker.volume = NumericHelper.to_d(output[8])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
