module Cryptoexchange::Exchanges
  module Nuex
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
          "#{Cryptoexchange::Exchanges::Nuex::Market::API_URL}/ticker/24hr"
        end

        def adapt_all(output)
          output.map do |pair|
            # find match by capturing BTC / ETH / XRP and removing any empty strings returned
            base, target = pair['symbol'].split(/(BTC)+(.*)|(ETH$)+(.*)|(XRP$)+(.*)/).reject(&:empty?)
            next unless base && target
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Nuex::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Nuex::Market::NAME
          ticker.last = NumericHelper.to_d(output['lastPrice'])
          ticker.bid = NumericHelper.to_d(output['bidPrice'])
          ticker.ask = NumericHelper.to_d(output['askPrice'])
          ticker.high = NumericHelper.to_d(output['highPrice'])
          ticker.low = NumericHelper.to_d(output['lowPrice'])
          ticker.volume = NumericHelper.to_d(output['volume'].to_f/output['lastPrice'].to_f)
          ticker.change = NumericHelper.to_d(output['priceChangePercent'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
