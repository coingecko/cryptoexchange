module Cryptoexchange::Exchanges
  module Tokenjar
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          raw_output = HTTP.get(ticker_url)
          output = JSON.parse(raw_output)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Tokenjar::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            if pair[1]['isFrozen'] == "0"
              base, target = pair[0].gsub(' ', '').split('_')
              market_pair = Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: Tokenjar::Market::NAME
                            )
              adapt(market_pair, pair[1])
           end
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Tokenjar::Market::NAME
          ticker.ask = NumericHelper.to_d(output['lowestAsk'])
          ticker.bid = NumericHelper.to_d(output['highestBid'])
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.high = NumericHelper.to_d(output['high24hr'])
          ticker.low = NumericHelper.to_d(output['low24hr'])
          ticker.volume = NumericHelper.to_d(output['quoteVolume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
