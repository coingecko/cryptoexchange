module Cryptoexchange::Exchanges
  module CoinMetro
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
          "#{Cryptoexchange::Exchanges::CoinMetro::Market::API_URL}/prices"
        end

        def adapt_all(output)
          market_info = output['24hInfo']
          output["latestPrices"].each_with_index.map do |ticker, idx|
            pair = ticker["pair"]
            separator = /(BTC|ETH|EUR)\z/i =~ pair

            base      = pair[0..separator - 1]
            target    = pair[separator..-1]

            next if base.nil? || target.nil?

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: CoinMetro::Market::NAME
            )

            ticker = ticker.merge(market_info[idx])
            adapt(ticker, market_pair)
          end.compact
        end

        def adapt(output, market_pair)
          if output.empty?
            nil
          else
            ticker = Cryptoexchange::Models::Ticker.new
            ticker.base = market_pair.base
            ticker.target = market_pair.target
            ticker.market = CoinMetro::Market::NAME
            ticker.ask = NumericHelper.to_d(output['ask'])
            ticker.bid = NumericHelper.to_d(output['bid'])
            ticker.last = NumericHelper.to_d(output['price'])
            ticker.high = NumericHelper.to_d(output['h'])
            ticker.low = NumericHelper.to_d(output['l'])
            ticker.volume = NumericHelper.to_d(output['v'])
            ticker.timestamp = nil
            ticker.payload = output
            ticker
          end
        end
      end
    end
  end
end
