module Cryptoexchange::Exchanges
  module Bancor
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super ticker_url
          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Bancor::Market::API_URL}/exchanges?platform=bancor&key=#{Cryptoexchange::Exchanges::Bancor::Market.api_key}"
        end

        def adapt_all(output)
          output['results'].map do |ticker|
            next if ticker["tokenSymbol"] == nil || ticker["baseSymbol"] == nil
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: ticker["tokenSymbol"],
                            target: ticker["baseSymbol"],
                            market: Bancor::Market::NAME
                          )

            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = Bancor::Market::NAME
          ticker.last = NumericHelper.to_d(output['basePrice'])
          ticker.volume = NumericHelper.flip_volume(NumericHelper.to_d(output['baseVolume']), ticker.last)
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
