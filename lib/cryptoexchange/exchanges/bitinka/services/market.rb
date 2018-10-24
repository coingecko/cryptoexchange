module Cryptoexchange::Exchanges
  module Bitinka
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
          "#{Cryptoexchange::Exchanges::Bitinka::Market::API_URL}/ticker?format=json"
        end

        def adapt_all(output)
          tickers = []
          output.each do |base, pairs|
            base = base
            pairs.each do |pair_output|
              target = pair_output["symbol"].split("_").last

              market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Cryptoexchange::Exchanges::Bitinka::Market::NAME
              )
              tickers << adapt(market_pair, pair_output)
            end
          end

          tickers
        end

        def adapt(market_pair, pair_output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Cryptoexchange::Exchanges::Bitinka::Market::NAME
          ticker.last      = NumericHelper.to_d(pair_output['lastPrice'])
          ticker.bid       = NumericHelper.to_d(pair_output['bid'])
          ticker.ask       = NumericHelper.to_d(pair_output['ask'])
          ticker.volume    = NumericHelper.to_d(pair_output['volumen24hours'])
          ticker.timestamp = nil
          ticker.payload   = pair_output
          ticker
        end
      end
    end
  end
end
