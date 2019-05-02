module Cryptoexchange::Exchanges
  module P2pb2b
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
          "#{Cryptoexchange::Exchanges::P2pb2b::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['result'].map do |pair|
            base, target = pair[0].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base.upcase,
                            target: target.upcase,
                            market: P2pb2b::Market::NAME
                          )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = P2pb2b::Market::NAME
          ticker.last = NumericHelper.to_d(output['ticker']['last'])
          ticker.bid = NumericHelper.to_d(output['ticker']['bid'])
          ticker.ask = NumericHelper.to_d(output['ticker']['ask'])
          ticker.high = NumericHelper.to_d(output['ticker']['high'])
          ticker.low = NumericHelper.to_d(output['ticker']['low'])
          ticker.volume = NumericHelper.to_d(output['ticker']['vol'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
