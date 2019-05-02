module Cryptoexchange::Exchanges
  module B2bx
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = Cryptoexchange::Cache.ticker_cache.fetch(ticker_url) do
            HTTP.use(:auto_inflate).headers("Accept-Encoding" => "gzip").get(ticker_url).parse(:json)
          end

          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::B2bx::Market::API_URL}"
        end

        def adapt_all(output)
          output.map do |pair|
            symbol = pair['Instrument']
            base, target = symbol.split(Cryptoexchange::Exchanges::B2bx::Market::SUPPORTED_PAIRS_REGEX)
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: B2bx::Market::NAME
            )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = B2bx::Market::NAME
          ticker.last      = NumericHelper.to_d(output['LastTradedPx'].to_f)
          ticker.bid       = NumericHelper.to_d(output['BestBid'])
          ticker.ask       = NumericHelper.to_d(output['BestOffer'])
          ticker.volume    = NumericHelper.to_d(output['Rolling24HrVolume'].to_f)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
