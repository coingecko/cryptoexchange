module Cryptoexchange::Exchanges
  module Bitmex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end
      
        def fetch(market_pair)
          ticker_market_url = super(ticker_market_url(market_pair))[0]
          expiration = super(expiration_url(market_pair))[0]
          open_interest = super(open_interest_url(market_pair))[0]
          funding = super(funding_url(market_pair))[0]
          index = super(index_url(market_pair))[0]
          adapt(ticker_market_url, expiration, open_interest, funding, index, market_pair)
        end

        def adapt(ticker_market, expiration, open_interest, funding, index, market_pair)
          ticker = Cryptoexchange::Models::TickerDerivative.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bitmex::Market::NAME
          ticker.inst_id = market_pair.inst_id
          ticker.ask = NumericHelper.to_d(ticker_market['askPrice'])
          ticker.bid = NumericHelper.to_d(ticker_market['bidPrice'])
          ticker.last = NumericHelper.to_d(ticker_market['lastPrice'])
          ticker.high = NumericHelper.to_d(ticker_market['highPrice'])
          ticker.low = NumericHelper.to_d(ticker_market['lowPrice'])
          ticker.volume = NumericHelper.to_d(ticker_market['homeNotional24h'])

          # Derivatives
          ticker.start_timestamp = DateTime.parse(expiration["listing"]).to_time.to_i if expiration["listing"]
          ticker.expire_timestamp = DateTime.parse(expiration["expiry"]).to_time.to_i if expiration["expiry"]
          ticker.open_interest = open_interest['openInterest'].to_f
          ticker.index     = index['indicativeSettlePrice'].to_f
          ticker.funding_rate = funding['fundingRate'].to_f
          ticker.funding_rate_timestamp = DateTime.parse(funding['fundingTimestamp']).to_time.to_i
          ticker.next_funding_rate_predicted = funding['indicativeFundingRate'].to_f

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
          "#{Cryptoexchange::Exchanges::Bitmex::Market::API_URL}/instrument?symbol=#{market_pair.inst_id}&count=100&reverse=true"
        end

        def expiration_url(market_pair)
          ticker_url(market_pair)
        end

        def open_interest_url(market_pair)
          ticker_url(market_pair)
        end

        def funding_url(market_pair)
          ticker_url(market_pair)
        end

        def index_url(market_pair)
          ticker_url(market_pair)
        end
      end
    end
  end
end
