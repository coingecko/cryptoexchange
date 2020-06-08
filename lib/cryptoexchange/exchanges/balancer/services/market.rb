module Cryptoexchange::Exchanges
  module Balancer
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        HOURS_24 = 24*60*60

        def fetch(market_pair)
          base = market_pair.base
          target = market_pair.target
          base = "WETH" if market_pair.base == "ETH"
          target = "WETH" if market_pair.target == "ETH"

          # Get swaps from both direction
          # Example, DAI-ETH and ETH-DAI
          swaps_response = TheGraphClient::Client.query(TheGraphClient::SwapsQuery, variables: { from: base, to: target, range_timestamp: Time.now.to_i - HOURS_24 })
          swaps_response_inverse = TheGraphClient::Client.query(TheGraphClient::SwapsQuery, variables: { from: target, to: base, range_timestamp: Time.now.to_i - HOURS_24 })
          latest_swap = swaps_response.data.swaps.first
          latest_swap_inverse = swaps_response_inverse.data.swaps.first

          # Depending on the latest swap, price derived differently, due to different direction
          last_price = if latest_swap.timestamp > latest_swap_inverse.timestamp
            latest_swap.token_amount_out.to_f / latest_swap.token_amount_in.to_f
          else
            latest_swap_inverse.token_amount_in.to_f / latest_swap_inverse.token_amount_out.to_f
          end
          volume = swaps_response.data.swaps.map(&:token_amount_in).map { |s| s.to_f }.sum
          volume_inverse = swaps_response_inverse.data.swaps.map(&:token_amount_out).map { |s| s.to_f }.sum

          adapt(last_price, market_pair, volume + volume_inverse)
        end

        def adapt(last_price, market_pair, volume)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Balancer::Market::NAME
          ticker.last      = last_price.to_f
          ticker.volume    = volume.to_f
          ticker.timestamp = nil
          ticker.payload   = { last_price: last_price, volume: volume }
          ticker
        end
      end
    end
  end
end
