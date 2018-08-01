module Cryptoexchange::Exchanges
  module Escodex
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
          "#{Cryptoexchange::Exchanges::Escodex::Market::API_URL}/ticker"
        end

        def adapt_all(output)
          output.map do |pair|
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: pair['quote'],
                            target: pair['base'],
                            market: Escodex::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Escodex::Market::NAME
          ticker.last = NumericHelper.to_d(output['latest'])
          ticker.bid = NumericHelper.to_d(output['highest_bid'])
          ticker.ask = NumericHelper.to_d(output['lowest_ask'])
          ticker.volume = NumericHelper.to_d(output['quote_volume'])
          ticker.timestamp = DateTime.parse(output['time']).to_time.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
