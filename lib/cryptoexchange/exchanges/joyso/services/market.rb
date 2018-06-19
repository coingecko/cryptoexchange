module Cryptoexchange::Exchanges
  module Joyso
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output['tickers'])
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Joyso::Market::API_URL}/tickers/market"
        end

        def adapt_all(output)
          output.map do |pair|
            target, base = pair['pair'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Joyso::Market::NAME
                          )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Joyso::Market::NAME
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.volume = NumericHelper.to_d(output['qoute_volume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
