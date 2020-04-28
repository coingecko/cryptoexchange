module Cryptoexchange::Exchanges
  module IndependentReserve
    module Services
      class Market < Cryptoexchange::Services::Market
        # this exchange share the volume across 3 fiat, need divide the volume by 3
        FIAT_SHARED_VOLUME = 3

        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::IndependentReserve::Market::API_URL}/GetMarketSummary?primaryCurrencyCode=#{base}&secondaryCurrencyCode=#{target}"
        end

        def adapt(output, market_pair)
          output           = output
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = IndependentReserve::Market::NAME
          ticker.bid       = NumericHelper.to_d(output['CurrentHighestBidPrice'])
          ticker.ask       = NumericHelper.to_d(output['CurrentLowestOfferPrice'])
          ticker.last      = NumericHelper.to_d(output['LastPrice'])
          ticker.high      = NumericHelper.to_d(output['DayHighestPrice'])
          ticker.low       = NumericHelper.to_d(output['DayLowestPrice'])
          ticker.volume    = NumericHelper.to_d(output["DayVolumeXbt"]) / FIAT_SHARED_VOLUME
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
