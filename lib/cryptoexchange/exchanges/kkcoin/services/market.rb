module Cryptoexchange::Exchanges
  module Kkcoin
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
          "#{Cryptoexchange::Exchanges::Kkcoin::Market::API_URL}/allticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target = ticker[0].split("_")
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Kkcoin::Market::NAME
            )
            adapt(market_pair, ticker)
          end
        end

        #  [
        #    "KK_ETH",      // Symbol                        -> 0
        #    "0.00000523",  // Best bid price                -> 1
        #    "30582",       // Best bid amount               -> 2
        #    "0.00000526",  // Best ask price                -> 3
        #    "321179",      // Best ask amount               -> 4
        #    "-0.00000005", // Price change of last 24 hours -> 5
        #    "-0.0095",     // Price change rate             -> 6
        #    "0.00000522",  // Last trade price              -> 7
        #    "232.88",      // Daily volume                  -> 8
        #    "0.00000530",  // Daily high                    -> 9
        #    "0.00000495",  // Daily low                     -> 10
        #    "46576000.00"  // Daily amount                  -> 11
        #  ]

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Kkcoin::Market::NAME
          ticker.last      = NumericHelper.to_d(output[7])
          ticker.bid       = NumericHelper.to_d(output[1])
          ticker.ask       = NumericHelper.to_d(output[3])
          ticker.high      = NumericHelper.to_d(output[9])
          ticker.low       = NumericHelper.to_d(output[10])
          ticker.change    = NumericHelper.to_d(output[6])
          ticker.volume    = NumericHelper.to_d(output[11])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
