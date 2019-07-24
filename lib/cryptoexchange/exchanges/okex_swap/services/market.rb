module Cryptoexchange::Exchanges
  module OkexSwap
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
          "#{Cryptoexchange::Exchanges::OkexSwap::Market::API_URL}/instruments/ticker"
        end

        def adapt_all(output)
          output.map do |ticker|
            base, target, expire_at = ticker['instrument_id'].split('-')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: OkexSwap::Market::NAME,
              contract_interval: "perpetual",
            )
            adapt(ticker, market_pair)
          end
        end

        def get_volume_in_target(volume, market_pair)
          if market_pair.base == "BTC"
            volume_in_target = volume * 100
          else
            volume_in_target = volume * 10
          end
          volume_in_target
        end

        def adapt(output, market_pair)
          volume_in_target = get_volume_in_target(NumericHelper.to_d(output['volume_24h']), market_pair)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = OkexSwap::Market::NAME
          ticker.ask       = NumericHelper.to_d(output['best_ask'])
          ticker.bid       = NumericHelper.to_d(output['best_bid'])
          ticker.last      = NumericHelper.to_d(output['last'])
          ticker.high      = NumericHelper.to_d(output['high_24h'])
          ticker.low       = NumericHelper.to_d(output['low_24h'])
          ticker.volume    = NumericHelper.divide(volume_in_target, ticker.last)
          ticker.timestamp = nil
          ticker.payload   = output
          ticker.contract_interval = "perpetual"
          ticker
        end
      end
    end
  end
end
