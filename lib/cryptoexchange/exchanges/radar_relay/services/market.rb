module Cryptoexchange::Exchanges
  module RadarRelay
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          outputs = []
          (1..25).each do |page_id|
            ticker_output = super(ticker_url(page_id))
            break if ticker_output.empty?
            outputs = outputs + ticker_output
          end
          adapt_all(outputs)
        end

        def ticker_url(page_id)
          "#{Cryptoexchange::Exchanges::RadarRelay::Market::API_URL}/markets?include=base,stats,ticker&page=#{page_id}&perPage=100"
        end

        def adapt_all(output)
          output.map do |pair_ticker|
            base, target = pair_ticker["id"].split("-")
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: RadarRelay::Market::NAME
            )
            adapt(market_pair, pair_ticker["ticker"], pair_ticker["stats"])
          end
        end

        def adapt(market_pair, ticker_output, stats_output)
          ticker = Cryptoexchange::Models::Ticker.new

          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = RadarRelay::Market::NAME
          ticker.bid       = NumericHelper.to_d(ticker_output['bestBid'])
          ticker.ask       = NumericHelper.to_d(ticker_output['bestAsk'])
          ticker.last      = NumericHelper.to_d(ticker_output['price'])
          ticker.volume    = NumericHelper.divide(NumericHelper.to_d(stats_output['volume24Hour']), ticker.last)
          ticker.change    = NumericHelper.to_d(stats_output['percentChange24Hour'])
          ticker.timestamp = NumericHelper.to_d(ticker_output['timestamp'])
          ticker.payload   = [ticker_output, stats_output]
          ticker
        end
      end
    end
  end
end
