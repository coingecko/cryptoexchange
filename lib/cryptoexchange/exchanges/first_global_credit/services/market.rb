module Cryptoexchange::Exchanges
  module FirstGlobalCredit
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
          "#{Cryptoexchange::Exchanges::FirstGlobalCredit::Market::API_URL}"
        end

        def adapt_all(output)
          output.map do |pair|
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: pair['base_currency'],
                            market: pair['currency_pair'],
                            target: pair['float_currency'],
                          )
            adapt(market_pair, pair)
          end
        end

        def adapt(market_pair, output)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = market_pair.market
          ticker.ask = NumericHelper.to_d(output['ask'])
          ticker.bid = NumericHelper.to_d(output['bid'])
          ticker.last = NumericHelper.to_d(output['last_price'])
          ticker.volume = ticker.volume = NumericHelper.to_d(output['base_volume'])
          ticker.timestamp = Time.now.to_i
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
