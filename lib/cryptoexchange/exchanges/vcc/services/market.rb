module Cryptoexchange::Exchanges
  module Vcc
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
          "#{Cryptoexchange::Exchanges::Vcc::Market::API_URL}/summary"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair[0].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Vcc::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          output = output[1]
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Vcc::Market::NAME
          ticker.last = NumericHelper.to_d(output['last'].to_f)
          ticker.bid = NumericHelper.to_d(output['highestBid'].to_f)
          ticker.ask = NumericHelper.to_d(output['lowestAsk'].to_f)
          ticker.high = NumericHelper.to_d(output['high24hr'].to_f)
          ticker.low = NumericHelper.to_d(output['low24hr'].to_f)
          ticker.volume = NumericHelper.to_d(output['baseVolume']).to_f
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
