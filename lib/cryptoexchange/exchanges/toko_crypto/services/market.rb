module Cryptoexchange::Exchanges
  module TokoCrypto
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
          "#{Cryptoexchange::Exchanges::TokoCrypto::Market::API_URL}/rates/tickers"
        end

        def adapt_all(output)
          output['data'].map do |ticker|
            base, target = TokoCrypto::Market.separate_symbol(ticker["Name"])
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base:   base,
                            target: target,
                            market: TokoCrypto::Market::NAME
                          )

            adapt(market_pair, ticker)
          end.compact
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = TokoCrypto::Market::NAME
          ticker.last = NumericHelper.to_d(output['Close'])
          ticker.volume = NumericHelper.flip_volume(NumericHelper.to_d(output['Volume']),ticker.last)
          ticker.high = NumericHelper.to_d(output['High'])
          ticker.low = NumericHelper.to_d(output['Low'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
