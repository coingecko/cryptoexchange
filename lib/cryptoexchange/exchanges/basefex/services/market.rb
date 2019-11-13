module Cryptoexchange::Exchanges
  module Basefex
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
          "#{Cryptoexchange::Exchanges::Basefex::Market::API_URL}/instruments"
        end

        def adapt_all(output)
          output.map do |pair|
            base, target = Basefex::Market.separate_symbol(pair["symbol"])
            market_pair = Cryptoexchange::Models::MarketPair.new(
                            base: base,
                            target: target,
                            inst_id: pair["symbol"],
                            contract_interval: "perpetual",
                            market: Basefex::Market::NAME
                          )

            adapt(pair, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new
          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.contract_interval = market_pair.contract_interval
          ticker.inst_id = market_pair.inst_id
          ticker.market = Basefex::Market::NAME
          ticker.last = NumericHelper.to_d(output['latestPrice'])
          ticker.high = NumericHelper.to_d(output['last24hMaxPrice'])
          ticker.low = NumericHelper.to_d(output['last24hMinPrice'])
          ticker.volume = NumericHelper.to_d(output['turnover24h'])
          ticker.change = NumericHelper.to_d(output['last24hPriceChange'])
          ticker.timestamp = nil
          ticker.payload = output
          ticker
        end
      end
    end
  end
end
