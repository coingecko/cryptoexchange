require "graphql/client"
require "graphql/client/http"

module Cryptoexchange::Exchanges
  module Uniswap
    class TheGraphClient < Cryptoexchange::Models::Market
      HTTP = GraphQL::Client::HTTP.new("https://api.thegraph.com/subgraphs/name/uniswap/uniswap-v2") do
      end
      Schema = GraphQL::Client.load_schema(HTTP)
      Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

      TokenDayDataQuery = Client.parse <<-'GRAPHQL'
      query($token: String!, $range_timestamp: Int!)
      {
        tokenDayDatas(orderBy: date, orderDirection: desc, where: { token: $token, date_gte: $range_timestamp }){
          id
          token{
            symbol
            id
            derivedETH
          }
          date,
          dailyVolumeToken,
          date
        }
      }
      GRAPHQL
    end
  end
end
