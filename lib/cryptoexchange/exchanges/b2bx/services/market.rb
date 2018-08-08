module Cryptoexchange::Exchanges
  module B2bx
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          raw_output = HTTP.use(:auto_inflate).headers("Accept-Encoding" => "gzip").get(ticker_url)
          output = JSON.parse(raw_output)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::B2bx::Market::API_URL}/public/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            symbol = pair['Symbol'].gsub(".", "")
            base, target = symbol.split(/(BTC$)+|(ETH$)+(.*)|(USDT$)+(.*)|(USD$)+(.*)|(BCH$)+(.*)|(DASH$)+(.*)|(XRP$)+(.*)|(OMG$)+(.*)|(XMR$)+(.*)|(LTC$)+(.*)/)
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: B2bx::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = B2bx::Market::NAME
          ticker.last      = NumericHelper.to_d(output['LastBuyPrice'].to_f)
          ticker.bid       = NumericHelper.to_d(output['BestBid'])
          ticker.ask       = NumericHelper.to_d(output['BestAsk'])
          ticker.volume    = NumericHelper.to_d(output['DailyTradedTotalVolume'].to_f)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
