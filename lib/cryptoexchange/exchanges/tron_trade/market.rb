module Cryptoexchange::Exchanges
  module TronTrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'tron_trade'
      API_URL = 'https://trontrade.io/graphql'
    end
  end
end
