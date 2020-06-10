require "graphql/client"
require "graphql/client/http"

module Cryptoexchange::Exchanges
  module Curve
    class TheGraphClient < Cryptoexchange::Models::Market
      HTTP = GraphQL::Client::HTTP.new("https://api.thegraph.com/subgraphs/name/blocklytics/curve") do
      end
      Schema = GraphQL::Client.load_schema(HTTP)
      Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

      TokensQuery = Client.parse <<-'GRAPHQL'
      query
      {
        tokens {
          id
          symbol
          decimals
        }
      }
      GRAPHQL

      SwapsQuery = Client.parse <<-'GRAPHQL'
      query($fromToken: String!, $toToken: String!, $range_timestamp: BigInt!)
      {
        swaps(orderBy: timestamp, orderDirection: desc, first: 1000, where: { fromToken: $fromToken, toToken: $toToken, timestamp_gte: $range_timestamp } ){
          fromTokenAmount,
          toTokenAmount,
          underlyingPrice,
          timestamp
        }
      }
      GRAPHQL
    end
  end
end
