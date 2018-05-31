module Cryptoexchange::Exchanges
  module Braziliex
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
          "#{Cryptoexchange::Exchanges::Braziliex::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair[0].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base.upcase,
                            target: target.upcase,
                            market: Braziliex::Market::NAME
                          )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Braziliex::Market::NAME
          ticker.last = NumericHelper.to_d(output['last'].to_f)
          ticker.bid = NumericHelper.to_d(output['highestBid24'].to_f)
          ticker.ask = NumericHelper.to_d(output['lowestAsk24'].to_f)
          ticker.high = NumericHelper.to_d(output['highestBid'].to_f)
          ticker.low = NumericHelper.to_d(output['lowestAsk'].to_f)
          ticker.volume = NumericHelper.to_d(output['baseVolume24'].to_f)
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
