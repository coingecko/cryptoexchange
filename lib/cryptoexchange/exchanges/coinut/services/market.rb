module Cryptoexchange::Exchanges
  module Coinut
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          authentication = Cryptoexchange::Exchanges::Coinut::Authentication.new(
            :market,
            Cryptoexchange::Exchanges::Coinut::Market::NAME
          )
          authentication.validate_credentials!

          payload_ = payload(market_pair)
          headers = authentication.headers(payload_)
          output = fetch_using_post(ticker_url, payload_, headers)
          adapt(output, market_pair)
        end

        def payload(market_pair)
          '{"nonce":' + SecureRandom.random_number(99999).to_s + ',"request":"inst_tick", "inst_id":' + market_pair.inst_id + ' }'
        end

        def ticker_url
          Cryptoexchange::Exchanges::Coinut::Market::API_URL
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coinut::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['highest_buy'])
          ticker.low       = NumericHelper.to_d(output['lowest_sell'])
          ticker.volume    = NumericHelper.to_d(output['volume24'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
