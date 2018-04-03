module Cryptoexchange::Exchanges
  module CryptoHub
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
          "#{Cryptoexchange::Exchanges::CryptoHub::Market::API_URL}/market/ticker/"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            target, base = pair.split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: CryptoHub::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = CryptoHub::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['highestBid'])
          ticker.low       = NumericHelper.to_d(output['lowestAsk'])
          ticker.change    = NumericHelper.to_d(output['percentChange'])
          ticker.volume    = NumericHelper.to_d(output['quoteVolume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
