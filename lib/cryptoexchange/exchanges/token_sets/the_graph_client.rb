require "graphql/client"
require "graphql/client/http"

module Cryptoexchange::Exchanges
  module TokenSets
    class TheGraphClient < Cryptoexchange::Models::Market
      HTTP = GraphQL::Client::HTTP.new("https://api.thegraph.com/subgraphs/name/destiner/token-sets") do
      end
      Schema = GraphQL::Client.load_schema(HTTP)
      Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

      IssuancesQuery = Client.parse <<-'GRAPHQL'
      query($contract_address: String!, $range_timestamp: BigInt!)
      {
        issuances(orderBy: timestamp, orderDirection: desc, where: { set_: $contract_address, timestamp_gte: $range_timestamp }) {
          id
          set_ {
            address
            name
            symbol
          }
      amount
          timestamp
        }
      }
      GRAPHQL

      RedemptionsQuery = Client.parse <<-'GRAPHQL'
      query($contract_address: String!, $range_timestamp: BigInt!)
      {
        redemptions(orderBy: timestamp, orderDirection: desc, where: { set_: $contract_address, timestamp_gte: $range_timestamp }) {
          id
          set_ {
            address
            name
            symbol
          }
      amount
          timestamp
        }
      }
      GRAPHQL
    end
  end
end
