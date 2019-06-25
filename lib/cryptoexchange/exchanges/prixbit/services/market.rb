module Cryptoexchange::Exchanges
  module Prixbit
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
          "#{Cryptoexchange::Exchanges::Prixbit::Market::API_URL}/ticker/24hr/#{date_now}"
        end

        def date_now
          Date.today.to_s
        end

        def adapt_all(output)
          output["result"].map do |pair|
            base, target = pair["quoteAsset"], pair["baseAsset"]
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Prixbit::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Prixbit::Market::NAME
          ticker.last = NumericHelper.to_d(output['currentPrice'].to_f)
          ticker.high = NumericHelper.to_d(output['highPrice'].to_f)
          ticker.low = NumericHelper.to_d(output['lowPrice'].to_f)
          ticker.volume = NumericHelper.to_d(output['tradeVolum']).to_f
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
