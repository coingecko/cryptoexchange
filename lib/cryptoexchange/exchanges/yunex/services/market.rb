module Cryptoexchange::Exchanges
  module Yunex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          depthOutput = super(depth_url(market_pair))
          depth = adapt_depth1(depthOutput, market_pair)

          output = super(ticker_url(market_pair))
          adapt(output, market_pair, depth)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::Yunex::Market::API_URL}/api/market/trade/info?symbol=#{base}_#{target}"
        end

        def depth_url(market_pair)
            base = market_pair.base.downcase
            target = market_pair.target.downcase
            "#{Cryptoexchange::Exchanges::Yunex::Market::API_URL}/api/market/depth?symbol=#{base}_#{target}&level=1"
        end

        def adapt_depth1(output, market_pair)
            output["data"]
        end

        def adapt(output, market_pair, depth)

          market = output['data']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Yunex::Market::NAME


          ticker.ask       = NumericHelper.to_d(depth["asks"][0][0])
          ticker.bid       = NumericHelper.to_d(depth["bids"][0][0])

          ticker.high      = NumericHelper.to_d(market['max_price'])
          ticker.low       = NumericHelper.to_d(market['min_price'])
          ticker.last      = NumericHelper.to_d(market['cur_price'])
          ticker.volume    = NumericHelper.to_d(market['volume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output

          ticker
        end
      end
    end
  end
end
