module Cryptoexchange::Exchanges
  module Bitonbay
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
          "#{Cryptoexchange::Exchanges::Bitonbay::Market::API_URL}/api-public-ticker"
        end

        def adapt_all(output)
          output['lastprice'].map do |base, target|
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target.keys.first,
              market: Bitonbay::Market::NAME
            )
            adapt(market_pair, output)
          end.compact
        end

        def adapt(market_pair, output)
          last_data = output["lastprice"][market_pair.base.downcase]['btc']
          volume_data = output["accumamount"][market_pair.base.downcase]['btc']

          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Bitonbay::Market::NAME
          ticker.last      = last_data.nil? ? nil : NumericHelper.to_d(last_data)
          ticker.volume    = volume_data.nil? ? nil : NumericHelper.to_d(volume_data)
          ticker.timestamp = nil
          ticker.payload   = nil
          ticker
        end
      end
    end
  end
end
