module Cryptoexchange::Exchanges
  module Bitcratic
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          pair_list = super("#{Cryptoexchange::Exchanges::Bitcratic::Market::API_URL}.com/config/main.json")
          adapt_all(output, pair_list)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Bitcratic::Market::API_URL}.org/returnTicker"
        end

        def adapt_all(output, pairs)
          output.map do |ticker|
            pair = pairs["tokens"].find { |i| i if i["addr"] == ticker[1]["tokenAddr"] }
            next if pair.nil?
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: pair["name"],
              target: "ETH",
              market: Bitcratic::Market::NAME
            )
            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          output = output[1]
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitcratic::Market::NAME
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.bid      = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.to_d(output['quoteVolume']).to_f
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
