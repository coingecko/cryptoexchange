  module Cryptoexchange::Exchanges
  module Crypton
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
          "#{Cryptoexchange::Exchanges::Crypton::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          output['result'].map do |pair|
            base, target = pair[0].split('-')
            market_pair  = Cryptoexchange::Models::MarketPair.new(
              base:   base,
              target: target,
              market: Crypton::Market::NAME
            )
            adapt(market_pair, pair[1])
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Crypton::Market::NAME
          ticker.ask = NumericHelper.to_d(output['ask'].to_f)
          ticker.bid = NumericHelper.to_d(output['bid'].to_f)
          ticker.last = NumericHelper.to_d(output['last'].to_f)
          ticker.volume = (output['volume24h'] == nil) ? ['Nil'] : NumericHelper.to_d(output['volume24h'])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
