module Cryptoexchange::Exchanges
  module Uniswap
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
          "#{Cryptoexchange::Exchanges::Uniswap::Market::API_URL}&key=#{Cryptoexchange::Exchanges::Uniswap::Market.api_key}"
        end

        def adapt_all(output)
          output["results"].map do |pair|
            base = pair["tokenSymbol"]
            
            # Temporary workaround for duplicate symbols
            base = "#{pair['tokenSymbol']}-#{pair['token']}" if base == "ULT"

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: "ETH",
              market: Uniswap::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Uniswap::Market::NAME
          ticker.last      = NumericHelper.divide(1, NumericHelper.to_d(output['basePrice']))
          ticker.volume    = NumericHelper.to_d(output['tokenVolume'])
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
