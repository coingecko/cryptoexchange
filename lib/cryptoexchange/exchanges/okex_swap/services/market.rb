module Cryptoexchange::Exchanges
  module OkexSwap
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = if market_pair.contract_interval == "perpetual"
            super("https://www.okex.com/api/swap/v3/instruments/#{market_pair.inst_id}/ticker")
          else
            super("https://www.okex.com/api/futures/v3/instruments/#{market_pair.inst_id}/ticker")
          end
          adapt(output, market_pair)
        end

        def get_volume_in_target(volume, market_pair)
          if market_pair.base == "BTC"
            volume_in_target = volume * 100
          else
            volume_in_target = volume * 10
          end
          volume_in_target
        end

        def adapt(output, market_pair)
          volume_in_target = get_volume_in_target(NumericHelper.to_d(output['volume_24h']), market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = OkexSwap::Market::NAME
          ticker.inst_id   = market_pair.inst_id
          ticker.contract_interval = market_pair.contract_interval
          ticker.ask       = NumericHelper.to_d(output['best_ask'])
          ticker.bid       = NumericHelper.to_d(output['best_bid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high_24h'])
          ticker.low       = NumericHelper.to_d(output['low_24h'])
          ticker.volume    = NumericHelper.divide(volume_in_target, ticker.last)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
