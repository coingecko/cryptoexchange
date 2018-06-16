module Cryptoexchange::Exchanges
  module Liqnet
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
          "#{Cryptoexchange::Exchanges::Liqnet::Market::API_URL}/markets"
        end

        def adapt_all(output)
          output.map do |pair|
            if pair['is_frozen'] == false
              base, target = pair['market'].split('/')
              market_pair = Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Liqnet::Market::NAME
                            )
              adapt(market_pair, pair)
            end
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Liqnet::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['top_ask'])
          ticker.bid       = NumericHelper.to_d(output['top_bid'])
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.high      = NumericHelper.to_d(output['high_24hr'])
          ticker.low       = NumericHelper.to_d(output['low_24hr'])
          ticker.volume    = NumericHelper.to_d(output['volume_24hr'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
