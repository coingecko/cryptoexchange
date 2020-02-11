module Cryptoexchange::Exchanges
  module TokenSets
    module Services
      class Market < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end

        HOURS_24 = 24*60*60

        def fetch(market_pair)
          output = super(ticker_url(market_pair))
          contract_address = output["rebalancing_set"]["address"].downcase

          issuances_response = TheGraphClient::Client.query(TheGraphClient::IssuancesQuery, variables: { contract_address: contract_address, range_timestamp: Time.now.to_i - HOURS_24 })
          total_issuances = issuances_response.data.issuances.map(&:amount).map { |s| s.to_f / 1000000000000000000 }.sum

          redemptions_response = TheGraphClient::Client.query(TheGraphClient::RedemptionsQuery, variables: { contract_address: contract_address, range_timestamp: Time.now.to_i - HOURS_24 })
          total_redemptions = redemptions_response.data.redemptions.map(&:amount).map { |s| s.to_f / 1000000000000000000 }.sum
          volume = total_issuances + total_redemptions

          adapt(output, market_pair, volume)
        end

        def ticker_url(market_pair)
          "#{Cryptoexchange::Exchanges::TokenSets::Market::API_URL}/rebalancing_sets/#{market_pair.inst_id}"
        end

        def adapt(output, market_pair, volume)
          ticker           = Cryptoexchange::Models::Ticker.new
          ticker.base      = market_pair.base
          ticker.target    = market_pair.target
          ticker.market    = TokenSets::Market::NAME
          ticker.last      = output["rebalancing_set"]["price_usd"].to_f
          ticker.volume    = volume.to_f
          ticker.timestamp = nil
          ticker.payload   = output
          ticker
        end
      end
    end
  end
end
