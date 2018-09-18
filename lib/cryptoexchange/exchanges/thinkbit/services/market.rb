module Cryptoexchange::Exchanges
  module Thinkbit
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
          "#{Cryptoexchange::Exchanges::Thinkbit::Market::API_URL}/market/ticker"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair['pair'].split('_')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Thinkbit::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Thinkbit::Market::NAME
          ticker.last      = NumericHelper.to_d(output['current'].to_f)
          ticker.high      = NumericHelper.to_d(output['highest_24h'].to_f)
          ticker.low       = NumericHelper.to_d(output['lowest_24h'].to_f)
          ticker.bid       = NumericHelper.to_d(output['highest_bid'].to_f)
          ticker.ask       = NumericHelper.to_d(output['lowest_ask'].to_f)
          ticker.volume    = NumericHelper.to_d(output['volume_24h'].to_f)
          ticker.change    = NumericHelper.to_d(output['change_24h'].to_f)
          ticker.timestamp = output['time']/1000
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
