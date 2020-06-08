require "graphql/client"
require "graphql/client/http"

module Cryptoexchange::Exchanges
  module Balancer
    class TheGraphClient < Cryptoexchange::Models::Market
      HTTP = GraphQL::Client::HTTP.new("https://api.thegraph.com/subgraphs/name/balancer-labs/balancer") do
      end
      Schema = GraphQL::Client.load_schema(HTTP)
      Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

      SwapsQuery = Client.parse <<-'GRAPHQL'
      query($from: String!, $to: String!, $range_timestamp: Int!)
      {
        swaps(orderBy: timestamp, orderDirection: desc, where: { tokenInSym: $from, tokenOutSym: $to, timestamp_gte: $range_timestamp }) {
          id,
          tokenInSym,
          tokenOutSym,
          tokenAmountIn,
          tokenAmountOut,
          timestamp
        }
      }
      GRAPHQL
    end
  end
end
