module Cryptoexchange::Exchanges
  module Coinsuper
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
          "#{Cryptoexchange::Exchanges::Coinsuper::Market::API_URL}/market/hour24Market"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            if pair[1]['isFrozen']==0
              base, target = pair[0].split('/')
              market_pair = Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Coinsuper::Market::NAME
                            )
              adapt(market_pair, pair[1])
            end
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Coinsuper::Market::NAME
          ticker.ask = NumericHelper.to_d(output['lowestAsk'].to_f)
          ticker.bid = NumericHelper.to_d(output['highestBid'].to_f)
          ticker.last = NumericHelper.to_d(output['last'].to_f)
          ticker.high = NumericHelper.to_d(output['high24hr'].to_f)
          ticker.low = NumericHelper.to_d(output['low24Hr'].to_f)
          ticker.volume = NumericHelper.to_d(output['baseVolume'].to_f)
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
