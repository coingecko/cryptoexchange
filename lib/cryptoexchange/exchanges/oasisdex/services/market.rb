module Cryptoexchange::Exchanges
  module Oasisdex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Oasisdex::Market::API_URL}/markets/"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair[0].split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Oasisdex::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Oasisdex::Market::NAME
          ticker.ask = output[1]['ask'] == 'null' ? 0 : NumericHelper.to_d(output[1]['ask'].to_f)
          ticker.bid = output[1]['bid'] == 'null' ? 0 : NumericHelper.to_d(output[1]['bid'].to_f)
          ticker.last = output[1]['last'] == 'null' ? 0 : NumericHelper.to_d(output[1]['last'].to_f)
          ticker.high = output[1]['high'] == 'null' ? 0 : NumericHelper.to_d(output[1]['high'].to_f)
          ticker.low = output[1]['low'] == 'null' ? 0 : NumericHelper.to_d(output[1]['low'].to_f)
          ticker.volume = output[1]['vol'] == 'null' ? 0 : NumericHelper.to_d(output[1]['vol'].to_f)
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
