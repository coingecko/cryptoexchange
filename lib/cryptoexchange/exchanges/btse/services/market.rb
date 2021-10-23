module Cryptoexchange::Exchanges
  module Btse
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Btse::Market::API_URL}/market_summary"
        end

        def adapt_all(output)
          output.map do |pair, ticker|
            next unless (ticker["last"] && ticker["lowest_ask"] && ticker["highest_bid"] && ticker["percent_change"] && ticker["volume"])
            base, target = pair.split('-')
            market_pair = Cryptoexchange::Models::MarketPair.new({
                            base: base,
                            target: target,
                            market: Btse::Market::NAME
                          })
            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Btse::Market::NAME
          ticker.ask = NumericHelper.to_d(output['lowest_ask'])
          ticker.bid = NumericHelper.to_d(output['highest_bid'])
          ticker.last = NumericHelper.to_d(output['last'])
          ticker.high = NumericHelper.to_d(output['high24hr'])
          ticker.low = NumericHelper.to_d(output['low24hr'])
          ticker.volume = NumericHelper.to_d(output['volume']) / ticker.last
          ticker.change = NumericHelper.to_d(output['percent_change'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
