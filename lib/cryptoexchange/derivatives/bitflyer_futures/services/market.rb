module Cryptoexchange::Exchanges
  module BitflyerFutures
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          expirations = super(expiration_url)
          output = super(ticker_url(market_pair))

          expiration = expirations.select { |s| s["product_code"] == market_pair.inst_id }.first || nil

          adapt(output, market_pair, expiration)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BitflyerFutures::Market::API_URL}/ticker?product_code=#{market_pair.inst_id}"
        end

        def expiration_url
          "https://lightning.bitflyer.com/api/trade/derivativeproducts?includeClosed=false&"
        end

        def adapt(output, market_pair, expiration)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.contract_interval    = market_pair.contract_interval
          ticker.market    = BitflyerFutures::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['best_ask'])
          ticker.bid       = NumericHelper.to_d(output['best_bid'])
          ticker.last      = NumericHelper.to_d(output['ltp'])
          ticker.volume    = NumericHelper.to_d(output['volume_by_product'])

          # Derivatives
          ticker.start_timestamp = nil
          ticker.expire_timestamp = DateTime.parse(expiration["maturity_date"]).to_time.to_i if expiration

          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
