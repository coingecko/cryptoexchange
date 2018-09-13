module Cryptoexchange::Exchanges
  module Blockonix
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
          "#{Cryptoexchange::Exchanges::Blockonix::Market::API_URL}/marketData/public/"
        end

        def adapt_all(output)
          output.map do |pair|
            target, base = pair[0].split('/')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Blockonix::Market::NAME
            )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Blockonix::Market::NAME
          ticker.last      = NumericHelper.to_d(output['lastTradedPrice'].to_f)
          ticker.high      = NumericHelper.to_d(output['high_24_hours'].to_f)
          ticker.low       = NumericHelper.to_d(output['low_24_hours'].to_f)
          ticker.bid       = NumericHelper.to_d(output['highest_bid'].to_f)
          ticker.ask       = NumericHelper.to_d(output['lowest_ask'].to_f)
          ticker.volume    = NumericHelper.to_d(output['base_vol'].to_f)
          ticker.change    = NumericHelper.to_d(output['change'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
