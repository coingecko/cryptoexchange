module Cryptoexchange::Exchanges
  module Uniswap
    module Services
      class Market < Cryptoexchange::Services::Market
        RECOGNIZED_TARGETS = %w{ WETH DAI USDC USDT }

        class << self
          def supports_individual_ticker_query?
            false
          end
        end

        def fetch
          output = super(ticker_url)
          output = output["results"].select { |ticker| RECOGNIZED_TARGETS.include? ticker["assets"][1]["symbol"] }

          adapt_all(output)
        end

        def ticker_url
          "#{Cryptoexchange::Exchanges::Uniswap::Market::API_URL}/exchanges?platform=uniswap-v2&key=#{Cryptoexchange::Exchanges::Uniswap::Market.api_key}"
        end

        def adapt_all(output)
          dai_eth_ticker = output.select { |ticker| ticker["poolName"] == "Uniswap DAI-WETH"}.first
          eth_price_in_usd = dai_eth_ticker["assets"][0]["balance"] / dai_eth_ticker["assets"][1]["balance"]

          output.map do |pair|
            base = pair["assets"][0]["symbol"]
            target = pair["assets"][1]["symbol"]
            target = "ETH" if pair["assets"][1]["symbol"] == "WETH" # Fix WETH as ETH

            market_pair = Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Uniswap::Market::NAME
            )
            adapt(pair, market_pair, eth_price_in_usd)
          end
        end

        def adapt(output, market_pair, eth_price_in_usd)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Uniswap::Market::NAME
          ticker.last      = NumericHelper.divide(output["assets"][1]["balance"], output["assets"][0]["balance"])

          if market_pair.target == "ETH"
            ticker.volume  = NumericHelper.divide(NumericHelper.divide(output['usdVolume'], eth_price_in_usd), ticker.last)
          elsif ["USDC", "USDT", "DAI"].include? market_pair.target
            ticker.volume  = NumericHelper.divide(output['usdVolume'], ticker.last)
          end
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
