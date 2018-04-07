module Cryptoexchange::Exchanges
  module SouthXchange
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(self.ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::SouthXchange::Market::API_URL}/prices"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = pair['Market'].split('/')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: SouthXchange::Market::NAME
                          )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = SouthXchange::Market::NAME
          ticker.last      = NumericHelper.to_d(output['Last'])
          ticker.bid       = NumericHelper.to_d(output['Bid'])
          ticker.ask       = NumericHelper.to_d(output['Ask'])
          ticker.volume    = NumericHelper.to_d(output['Volume24Hr'])
          ticker.timestamp = Time.now.to_time.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
