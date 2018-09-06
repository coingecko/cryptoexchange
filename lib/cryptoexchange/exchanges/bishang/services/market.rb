module Cryptoexchange::Exchanges
  module Bishang
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
          "#{Cryptoexchange::Exchanges::Bishang::Market::API_URL}/allticker"
        end

        def adapt_all(output)
          output['ticker'].map do |pair|
            base, target = pair['symbol'].split('_')
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base.upcase,
                            target: target.upcase,
                            market: Bishang::Market::NAME
                          )
            adapt(market_pair, pair, output['date'])
          end
        end

        def adapt(market_pair, pair, date)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bishang::Market::NAME
          ticker.last = NumericHelper.to_d(pair['last'])
          ticker.bid = NumericHelper.to_d(pair['buy'])
          ticker.ask = NumericHelper.to_d(pair['sell'])
          ticker.high = NumericHelper.to_d(pair['high'])
          ticker.low = NumericHelper.to_d(pair['low'])
          ticker.change = NumericHelper.to_d(pair['change'])
          ticker.volume = NumericHelper.to_d(pair['vol'])
          ticker.timestamp = date.to_i
          ticker.payload = [pair, date]
          ticker
        end
      end
    end
  end
end
