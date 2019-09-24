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
          ticker_market = super(ticker_url(market_pair))
          expiration = super(expiration_url)
          index = super(index_url(market_pair))

          expiration = expiration.select { |s| s["product_code"] == market_pair.inst_id }.first || nil

          adapt(ticker_market, expiration, index, market_pair)
        end

        def adapt(ticker_market, expiration, index, market_pair)
          ticker           = Cryptoexchange::Models::TickerDerivative.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = BitflyerFutures::Market::NAME
          ticker.ask       = NumericHelper.to_d(ticker_market['best_ask'])
          ticker.bid       = NumericHelper.to_d(ticker_market['best_bid'])
          ticker.last      = NumericHelper.to_d(ticker_market['ltp'])
          ticker.volume    = NumericHelper.to_d(ticker_market['volume_by_product'])

          # Derivatives
          ticker.start_timestamp = nil
          ticker.expire_timestamp = DateTime.parse(expiration["maturity_date"]).to_time.to_i if expiration
          # ticker.open_interest
          ticker.index     = index['ltp'].to_f
          # ticker.funding_rate
          # ticker.funding_rate_timestamp
          # ticker.next_funding_rate_predicted

          ticker.timestamp = nil
          ticker.payload   = {
            ticker_market: ticker_market,
            expiration: expiration,
            index: index
          }
          ticker
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::BitflyerFutures::Market::API_URL}/ticker?product_code=#{market_pair.inst_id}"
        end

        def expiration_url
          "https://lightning.bitflyer.com/api/trade/derivativeproducts?includeClosed=false&"
        end

        def open_interest_url
        end

        def funding_url
        end

        def index_url(market_pair)
          "#{Cryptoexchange::Exchanges::BitflyerFutures::Market::API_URL}/ticker?product_code=#{market_pair.inst_id}"
        end
      end
    end
  end
end
