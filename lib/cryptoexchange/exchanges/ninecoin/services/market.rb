module Cryptoexchange::Exchanges
  module Ninecoin
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
          "#{Cryptoexchange::Exchanges::Ninecoin::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['data'].map do |pair|
            base, target = pair['cy_mark'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Ninecoin::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Ninecoin::Market::NAME
          ticker.last = NumericHelper.to_d(output['new_price'].to_f)
          ticker.bid = NumericHelper.to_d(output['buy_one_price'].to_f)
          ticker.ask = NumericHelper.to_d(output['sell_one_price'].to_f)
          ticker.high = NumericHelper.to_d(output['24H_max_price'].to_f)
          ticker.low = NumericHelper.to_d(output['24H_min_price'].to_f)
          ticker.volume = NumericHelper.divide(NumericHelper.to_d(output['24H_done_money']).to_f, ticker.last)
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
