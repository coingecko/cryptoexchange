module Cryptoexchange::Exchanges
  module Cryptaldash
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          adapt_all(output['market_summary'])
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Cryptaldash::Market::API_URL}/pubticker/all"
        end

        def adapt_all(output)
          output.map do |pair|
            symbol = pair['symbol'].upcase
            base, target = symbol.split(/(BTCONE$)+(.*)|(BTC$)+(.*)|(ETH$)+(.*)|(USDT$)+(.*)|(CRD$)+(.*)|(XEM$)+(.*)/)
            next unless base && target
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Cryptaldash::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Cryptaldash::Market::NAME
          ticker.last = NumericHelper.to_d(output['last_price'])
          ticker.bid = NumericHelper.to_d(output['bid'])
          ticker.ask = NumericHelper.to_d(output['ask'])
          ticker.high = NumericHelper.to_d(output['high24h'])
          ticker.low = NumericHelper.to_d(output['low24h'])
          ticker.volume = NumericHelper.to_d(output['volume24h'])
          ticker.change = NumericHelper.to_d(output['percent_change24h'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
