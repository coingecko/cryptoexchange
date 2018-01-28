module Cryptoexchange::Exchanges
  module Coinrail
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
          require 'byebug'
        end

        def fetch
          raw_output = super(ticker_url)
          output = []
          raw_output.map do |market|
            if market[0] == "btc_market" || market[0] == "krw_market"
              market[1].each { |pair|
                output.push(pair)
              }
            end
          end
          adapt_all(output)
        end

        def ticker_url
          # No API endpoint available to obtain tickers (as at 29/01/2018), hence the URL below:
          "https://coinrail.co.kr/main/market_info?v=#{(Time.now.to_f * 1000).to_i}"
        end

        def adapt_all(output)
          output.map do |pair|
              base, target = pair["currency"].split("-")
              market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Coinrail::Market::NAME
                          )
                          byebug
              adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target

          ticker.market = Coinrail::Market::NAME
          # ticker.ask = NumericHelper.to_d(output['sell'])
          # ticker.bid = NumericHelper.to_d(output['buy'])
          ticker.last = NumericHelper.to_d(output["last24_price"])
          # ticker.high = NumericHelper.to_d(output['high'])
          # ticker.low = NumericHelper.to_d(output['low'])
          ticker.volume = NumericHelper.to_d(output["trade_amount"])
          ticker.timestamp = output['time'].to_i
          ticker.payload = output
          byebug
          ticker
        end
      end
    end
  end
end
