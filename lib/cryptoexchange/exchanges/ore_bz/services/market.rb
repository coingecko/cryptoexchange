module Cryptoexchange::Exchanges
  module OreBz
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          adapt(output, market_pair)
        end

        def ticker_url(market_pair)
          base = market_pair.base.downcase
          target = market_pair.target.downcase
          "#{Cryptoexchange::Exchanges::OreBz::Market::API_URL}/tickers/#{base}#{target}.json"
        end

        def adapt(output, market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = market_pair.market

          ticker.last      = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'last'))
          ticker.bid       = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'buy'))
          ticker.ask       = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'sell'))
          ticker.high      = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'high'))
          ticker.low       = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'low'))
          ticker.volume    = NumericHelper.to_d(HashHelper.dig(output, 'ticker', 'vol'))
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
