module Cryptoexchange::Exchanges
  module Bitbns
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
          "#{Cryptoexchange::Exchanges::Bitbns::Market::API_URL}/order/getTickerWithVolume/"
        end

        def adapt_all(output)
          output.map do |pair|
            base = pair[0]
            target = 'INR'
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            market: Bitbns::Market::NAME
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bitbns::Market::NAME
          ticker.ask = NumericHelper.to_d(output[1]['lowest_sell_bid'])
          ticker.bid = NumericHelper.to_d(output[1]['highest_buy_bid'])
          ticker.last = NumericHelper.to_d(output[1]['last_traded_price'])
          ticker.volume = NumericHelper.to_d(output[1]['volume']['volume'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
