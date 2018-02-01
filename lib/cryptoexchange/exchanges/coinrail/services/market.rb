module Cryptoexchange::Exchanges
  module Coinrail
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
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
          "#{Cryptoexchange::Exchanges::Coinrail::Market::TICKER_URL}"
        end

        def adapt_all(output)
          output.map do |pair|
              base, target = pair["currency"].split("-")
              market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Coinrail::Market::NAME
                          )
              adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target

          ticker.market = Coinrail::Market::NAME
          ticker.last = NumericHelper.to_d(output["last24_price"])
          ticker.volume = NumericHelper.to_d(output["trade_amount"])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
