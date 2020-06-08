module Cryptoexchange::Exchanges
  module Curve
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        HOURS_24 = 24*60*60

        def fetch(market_pair)
          tokens_response = TheGraphClient::Client.query(TheGraphClient::TokensQuery)
          tokens = tokens_response.data.tokens
          
          # Get the token information
          # Decimals to calculate price, Id to pass into graphql
          base_token = tokens.select { |token| token.symbol == market_pair.base_raw }.first
          base_token_id = base_token.id
          base_token_decimals = base_token.decimals.to_i
          target_token = tokens.select { |token| token.symbol == market_pair.target_raw }.first
          target_token_id = target_token.id
          target_token_decimals = target_token.decimals.to_i

          # Get swaps from both direction
          # Example, DAI-ETH and ETH-DAI
          swaps_response = TheGraphClient::Client.query(TheGraphClient::SwapsQuery, variables: { fromToken: base_token_id, toToken: target_token_id, range_timestamp: Time.now.to_i - HOURS_24 })
          swaps_response_inverse = TheGraphClient::Client.query(TheGraphClient::SwapsQuery, variables: { fromToken: target_token_id, toToken: base_token_id, range_timestamp: Time.now.to_i - HOURS_24 })
          latest_swap = swaps_response.data.swaps.first
          latest_swap_inverse = swaps_response_inverse.data.swaps.first

          # Put the latest swap from both side together so we can compare and get the latest of the two
          latest_swaps = []
          latest_swaps << latest_swap if latest_swap
          latest_swaps << latest_swap_inverse if latest_swap_inverse
          last_swap =  latest_swaps.max_by { |k| k.timestamp}

          if last_swap
            last_price = 1.0 / last_swap.underlying_price.to_f
            volume = swaps_response.data.swaps.map(&:from_token_amount).map { |s| s.to_f / 10**base_token_decimals }.sum
            volume_inverse = swaps_response_inverse.data.swaps.map(&:to_token_amount).map { |s| s.to_f / 10**base_token_decimals }.sum

            adapt(last_price, market_pair, volume + volume_inverse)
          end
        end

        def adapt(last_price, market_pair, volume)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = Curve::Market::NAME
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
