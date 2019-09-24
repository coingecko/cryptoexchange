module Cryptoexchange::Exchanges
  module Ftx
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end
      
        def fetch(market_pair)
          ticker_market = super(ticker_market_url(market_pair))["result"]
          expiration = super(expiration_url(market_pair))["result"]
          open_interest = super(open_interest_url(market_pair))["result"]
          funding = super(funding_url(market_pair))["result"]
          index = super(index_url(market_pair))["result"]

          adapt(ticker_market, expiration, open_interest, funding, index, market_pair)
        end

        def adapt(ticker_market, expiration, open_interest, funding, index, market_pair)
          ticker = Cryptoexchange::Models::TickerDerivative.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Ftx::Market::NAME
          ticker.ask = NumericHelper.to_d(ticker_market["ask"])
          ticker.bid = NumericHelper.to_d(ticker_market["bid"])
          ticker.last = NumericHelper.to_d(ticker_market["last"])
          ticker.volume = NumericHelper.divide(NumericHelper.to_d(ticker_market["volumeUsd24h"]), ticker.last)
          
          # Derivatives
          ticker.start_timestamp = nil
          ticker.expire_timestamp = DateTime.parse(ticker_market["expiry"]).to_time.to_i if ticker_market["expiry"]
          ticker.open_interest = open_interest['openInterest'].to_f
          ticker.index     = index['index'].to_f
          ticker.funding_rate = open_interest['nextFundingRate'].to_f if open_interest['nextFundingRate']
          ticker.funding_rate_timestamp = DateTime.parse(open_interest['nextFundingTime']).to_time.to_i if open_interest['nextFundingTime']
          # ticker.next_funding_rate_predicted

          ticker.timestamp = nil
          ticker.payload = {
            ticker_market: ticker_market,
            expiration: expiration,
            open_interest: open_interest,
            funding: funding,
            index: index
          }
          ticker
        end

        def ticker_market_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ftx::Market::API_URL}/futures/#{market_pair.inst_id}"
        end

        def expiration_url(market_pair)
          ticker_market_url(market_pair)
        end

        def open_interest_url(market_pair)
          "#{Cryptoexchange::Exchanges::Ftx::Market::API_URL}/futures/#{market_pair.inst_id}/stats"
        end

        def funding_url(market_pair)
          ticker_market_url(market_pair)
        end

        def index_url(market_pair)
          ticker_market_url(market_pair)
        end
      end
    end
  end
end
