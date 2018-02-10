module Cryptoexchange::Exchanges
  module Rightbtc
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end
        TARGETS = ['ETH', 'BTC', 'BCY', 'ETP']

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Rightbtc::Market::API_URL}/tickers"
        end

        def adapt_all(output)
          markets = output['result']
          markets.map do |market|
            pair = market['market']
            base, target = strip_pairs(pair)
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: base,
                target: target,
                market: Rightbtc::Market::NAME
            )
            adapt(market, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Rightbtc::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['sell'])
          ticker.bid       = NumericHelper.to_d(output['buy'])
          ticker.last      = NumericHelper.to_d(output['last24h'])
          ticker.high      = NumericHelper.to_d(output['high24h'])
          ticker.low       = NumericHelper.to_d(output['low24h'])
          ticker.volume    = NumericHelper.to_d(output['vol24h'].abs)
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end

        def strip_pairs(pair)
          #Match last 3 or 4 if it hits target
          last_3 = pair[-3..-1]

          if TARGETS.include? last_3
            base = pair[0..-4]
            target = last_3
          end

          [base, target]
        end

      end
    end
  end
end
