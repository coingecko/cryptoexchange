module Cryptoexchange::Exchanges
  module Btcmarkets
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(market_pair, output)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::Btcmarkets::Market::API_URL}/market/#{market_pair.base}/#{market_pair.target}/tick"
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Btcmarkets::Market::NAME
          ticker.last      = NumericHelper.to_d(output['lastPrice'].to_f)
          ticker.bid       = NumericHelper.to_d(output['bestBid'].to_f)
          ticker.ask       = NumericHelper.to_d(output['bestAsk'].to_f)
          ticker.volume    = NumericHelper.to_d(output['volume24h'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
