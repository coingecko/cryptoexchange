module Cryptoexchange::Exchanges
  module TrxMarket
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
          "#{Cryptoexchange::Exchanges::TrxMarket::Market::API_URL}/dex/exchange/marketPair/list"
        end

        def adapt_all(output)
          output['data']['rows'].map do |ticker|
            base = ticker["fShortName"]
            target = ticker["sShortName"]
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            inst_id: ticker['id'],
                            market: TrxMarket::Market::NAME
                          )
            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = TrxMarket::Market::NAME
          ticker.last = NumericHelper.to_d(output['price']) / 10**output["sPrecision"]
          ticker.high = NumericHelper.to_d(output['highestPrice24h'])
          ticker.low = NumericHelper.to_d(output['lowestPrice24h'])
          ticker.volume = NumericHelper.to_d(output['volume']) / 10**output["fPrecision"]
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
