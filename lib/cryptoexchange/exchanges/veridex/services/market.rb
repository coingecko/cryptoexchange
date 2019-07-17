module Cryptoexchange::Exchanges
  module Veridex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          outputs = []
          (1..25).each do |page_id|
            ticker_output = super(ticker_url(page_id))
            break if ticker_output.empty?
            outputs = outputs + ticker_output
          end
          adapt_all(outputs)
        end

        def ticker_url(page_id)
          "#{Cryptoexchange::Exchanges::Veridex::Market::API_URL}/markets?include=stats&page=#{page_id}&perPage=25"
        end

        def adapt_all(output)
          output.map do |pair_ticker|
            base, target = pair_ticker["id"].split("-")
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Veridex::Market::NAME
            )
            adapt(market_pair, pair_ticker["stats"])
          end
        end

        def adapt(market_pair, stats_output)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Veridex::Market::NAME
          ticker.bid       = NumericHelper.to_d(stats_output['price_max_24'])
          ticker.ask       = NumericHelper.to_d(stats_output['price_min_24'])
          ticker.last      = NumericHelper.to_d(stats_output['last_price'])
          vol = NumericHelper.to_d(stats_output['volume_24'])
          ticker.volume    = (vol.nil? || vol == "") ? 0 : NumericHelper.divide(vol, ticker.last)
          ticker.change    = NumericHelper.to_d(stats_output['last_price_change'])
          ticker.timestamp = nil
          ticker.payload   = [stats_output]
          ticker
        end
      end
    end
  end
end
