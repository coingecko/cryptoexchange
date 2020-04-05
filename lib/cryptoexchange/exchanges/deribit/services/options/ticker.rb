module Cryptoexchange::Exchanges
  module Deribit
    module Services
      module Options
        class Ticker < Cryptoexchange::Services::Options::Ticker
          def fetch(market_pair)
            output = super(ticker_url(market_pair))
            adapt(output["result"], market_pair)
          end

          def ticker_url(market_pair)
            "#{Cryptoexchange::Exchanges::Deribit::Market::API_URL}/ticker?instrument_name=#{market_pair.inst_id}"
          end

          def adapt(output, market_pair)
            ticker = Cryptoexchange::Models::OptionTicker.new
            ticker.base = market_pair.base
            ticker.target = market_pair.target
            ticker.market = Deribit::Market::NAME
            ticker.last = NumericHelper.to_d(output['last_price'])
            ticker.inst_id = market_pair.inst_id

            ticker.ask = NumericHelper.to_d(output['best_ask_price'])
            ticker.ask_amount = NumericHelper.to_d(output['best_ask_amount'])
            ticker.bid = NumericHelper.to_d(output['best_bid_price'])
            ticker.bid_amount = NumericHelper.to_d(output['best_bid_amount'])
            ticker.volume = NumericHelper.to_d(output['stats']['volume'])
            ticker.low = NumericHelper.to_d(output['stats']['low'])
            ticker.high = NumericHelper.to_d(output['stats']['high'])
            ticker.change = NumericHelper.to_d(output['stats']['price_change'])

            ticker.underlying_price = NumericHelper.to_d(output['underlying_price'])
            ticker.underlying_index = NumericHelper.to_d(output['underlying_index'])
            ticker.state = NumericHelper.to_d(output['state'])
            ticker.settlement_price = NumericHelper.to_d(output['settlement_price'])
            ticker.greeks_vega = NumericHelper.to_d(output['greeks']['vega'])
            ticker.greeks_theta = NumericHelper.to_d(output['greeks']['theta'])
            ticker.greeks_rho = NumericHelper.to_d(output['greeks']['rho'])
            ticker.greeks_gamma = NumericHelper.to_d(output['greeks']['gamma'])
            ticker.greeks_delta = NumericHelper.to_d(output['greeks']['delta'])

            ticker.payload = output
            ticker
          end
        end
      end
    end
  end
end
