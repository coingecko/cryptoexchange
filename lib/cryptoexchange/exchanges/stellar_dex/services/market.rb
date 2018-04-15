module Cryptoexchange::Exchanges
  module StellarDex
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
          "#{Cryptoexchange::Exchanges::StellarDex::Market::API_URL}/ticker.json"
        end

        def adapt_all(output)
          # output is in hash
          # StellarTerm returns multiple anchor (sources) for pairs, eg XLM_BTC, XLM_ETH has 6 sources
          # and they do not group it, currently we exclude those pairs (only take pairs from 1 source)
          # until we have better API (one that does grouping for us)

          output['pairs'].map do |pairs, pairs_data|
            base = HashHelper.dig(pairs_data, 'baseBuying', 'code')
            target = HashHelper.dig(pairs_data, 'counterSelling', 'code')
            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: StellarDex::Market::NAME
            )

            adapt(pairs_data, market_pair)
          end
        end

        def adapt(output, market_pair)
          ticker = Cryptoexchange::Models::Ticker.new

          volume = if market_pair.target == "XLM"
            calculate_base_volume(output['volume24h_XLM'], output['price'])
          else
            nil
          end

          ticker.base = market_pair.base
          ticker.target = market_pair.target
          ticker.market = market_pair.market
          ticker.ask = NumericHelper.to_d(output['ask'])
          ticker.bid = NumericHelper.to_d(output['bid'])
          ticker.volume = volume
          ticker.timestamp = DateTime.now.to_time.to_i
          ticker.payload = output

          ticker
        end

        def calculate_base_volume(volume_target, price_target)
          volume_target / price_target
        rescue StandardError
          nil
        end
      end
    end
  end
end
