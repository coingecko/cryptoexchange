module Cryptoexchange::Exchanges
  module Mandala
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
          "#{Cryptoexchange::Exchanges::Mandala::Market::API_URL}/market/get-market-summary"
        end

        def adapt_all(output)

          data = output['data'].map
          data.each do |k, v|
            target, base = k.split("_")


            mp = Cryptoexchange::Models::MarketPair.new(
                base:   base,
                target: target,
                market: Mandala::Market::NAME
            )
            adapt(v, mp)

          end
        end

        def adapt(ticker_output, market_pair)

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Mandala::Market::NAME
          ticker.bid       = NumericHelper.to_d(ticker_output['HeighestBid'])
          ticker.ask       = NumericHelper.to_d(ticker_output['LowestAsk'])
          ticker.last      = NumericHelper.to_d(ticker_output['Last'])
          ticker.volume    = NumericHelper.to_d(ticker_output['QuoteVolume'])
          ticker.timestamp = nil
          ticker.payload   = ticker_output
          ticker
        end
      end
    end
  end
end
