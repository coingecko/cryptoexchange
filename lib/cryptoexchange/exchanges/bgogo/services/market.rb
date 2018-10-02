module Cryptoexchange::Exchanges
  module Bgogo
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = Bgogo::Market.ticker_fetch(ticker_url)
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Bgogo::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            next if pair == 'status'
            base, target = pair.split('/')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Bgogo::Market::NAME
            )
            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bgogo::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['lowest_ask_price'])
          ticker.bid       = NumericHelper.to_d(output['highest_bid_price'])
          ticker.last      = NumericHelper.to_d(output['last_price'])
          ticker.high      = NumericHelper.to_d(output['past_24hrs_high_price'])
          ticker.low       = NumericHelper.to_d(output['past_24hrs_low_price'])
          ticker.change    = NumericHelper.to_d(output['past_24hrs_price_change'].gsub(/[+-]|(%)/, ''))
          ticker.volume    = NumericHelper.to_d(output['past_24hrs_base_volume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
