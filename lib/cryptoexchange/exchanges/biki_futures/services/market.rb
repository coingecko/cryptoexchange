module Cryptoexchange::Exchanges
  module BikiFutures
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super ticker_url(market_pair)
          adapt(output["data"]["tickers"][0], market_pair)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BikiFutures::Market::API_URL}/tickers?instrumentID=#{market_pair.inst_id}"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.inst_id   = market_pair.inst_id
          ticker.contract_interval = market_pair.contract_interval          
          ticker.market    = BikiFutures::Market::NAME

          ticker.last      = NumericHelper.to_d(output['last_px'])
          ticker.volume    = NumericHelper.to_d(output['base_coin_qty'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.change    = NumericHelper.to_d(output['change_rate'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
