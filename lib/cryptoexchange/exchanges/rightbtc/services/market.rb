module Cryptoexchange::Exchanges
  module Rightbtc
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          pairs = super(pairs_url)
          adapt_all(output, pairs['status']['message'])
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Rightbtc::Market::API_URL}/tickers"
        end

        def pairs_url
          "#{Cryptoexchange::Exchanges::Rightbtc::Market::API_URL}/trading_pairs"
        end

        def adapt_all(output, pairs)
          markets = output['result']
          markets.map do |ticker|
            pair_object = pairs.select{|pair| pair == ticker['market']}
            market_pair = Cryptoexchange::Models::MarketPair.new(
                base: pair_object.values[0]['bid_asset_symbol'],
                target: pair_object.values[0]['ask_asset_symbol'],
                market: Rightbtc::Market::NAME
            )
            adapt(ticker, market_pair)
          end
        end

        def adapt(output, market_pair)
          i = 10**8
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Rightbtc::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['sell'].to_f/(i))
          ticker.bid       = NumericHelper.to_d(output['buy'].to_f/(i))
          ticker.last      = NumericHelper.to_d(output['last'].to_f/(i))
          ticker.high      = NumericHelper.to_d(output['high'].to_f/(i))
          ticker.low       = NumericHelper.to_d(output['low'].to_f/(i))
          ticker.volume    = NumericHelper.to_d(output['vol24h'].to_f/(i))
          ticker.timestamp = Time.now.to_i
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
