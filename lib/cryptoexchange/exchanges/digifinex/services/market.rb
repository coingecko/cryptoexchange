module Cryptoexchange::Exchanges
  module Digifinex
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          # due to the api limitation (self-pagination), cache is introduced here

          Cryptoexchange::Cache.ticker_cache.fetch(['Cryptoexchange', Digifinex::Market::NAME, 'tickers']) do
            tickers_array = []

            page = 1
            max_page = 1

            while page <= max_page do
              output = super ticker_url(page)
              tickers = adapt_all(output)
              tickers_array << tickers

              max_page = output["data"]["total_page"]
              page += 1
            end

            tickers_array.flatten.compact
          end
        end

        def ticker_url(page)
          "#{Cryptoexchange::Exchanges::Digifinex::Market::API_URL}/tickers?market=digifinex&size=100&page=#{page}"
        end

        def adapt_all(output)
          output["data"]["list"].map do |pair|
            base, target = pair['symbol_pair'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: CryptoBridge::Market::NAME
            )
            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Digifinex::Market::NAME

          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high'])
          ticker.low       = NumericHelper.to_d(output['low'])
          ticker.bid       = NumericHelper.to_d(output['bid'])
          ticker.ask       = NumericHelper.to_d(output['ask'])
          ticker.volume    = NumericHelper.to_d(output['vol'])
          ticker.change    = NumericHelper.to_d(output['change_daily'])

          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
