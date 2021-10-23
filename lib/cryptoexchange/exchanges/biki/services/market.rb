module Cryptoexchange::Exchanges
  module Biki
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
          "#{Cryptoexchange::Exchanges::Biki::Market::API_URL}/get_allticker"
        end

        def adapt_all(output)
          output["data"]["ticker"].map do |pair|
            base, target = Biki::Market.separate_symbol(pair["symbol"])
            next if base.nil? || target.nil?

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Biki::Market::NAME
            )

            adapt(market_pair, pair)
          end.compact
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Biki::Market::NAME

          ticker.bid       = NumericHelper.to_d(output["buy"])
          ticker.ask       = NumericHelper.to_d(output["sell"])
          ticker.last      = NumericHelper.to_d(output["last"])
          ticker.high      = NumericHelper.to_d(output["high"])
          ticker.low       = NumericHelper.to_d(output["low"])
          ticker.volume    = NumericHelper.to_d(output["vol"])
          ticker.change    = NumericHelper.to_d(output["change"])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
