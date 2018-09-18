module Cryptoexchange::Exchanges
  module Coindirect
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
          "#{Cryptoexchange::Exchanges::Coindirect::Market::API_URL}/exchange/market"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker['symbol'].split('-')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Coindirect::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker_info      = output['summary']
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Coindirect::Market::NAME
          ticker.ask       = NumericHelper.to_d(ticker_info['bestAsk'])
          ticker.bid       = NumericHelper.to_d(ticker_info['bestBid'])
          ticker.last      = NumericHelper.to_d(ticker_info['lastPrice'])
          ticker.change    = NumericHelper.to_d(ticker_info['change24h'])
          ticker.volume    = NumericHelper.to_d(ticker_info['volume24h'])
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
