module Cryptoexchange::Exchanges
  module Blackturtle
    class Market < Cryptoexchange::Models::Market
      NAME = 'blackturtle'
      API_URL = 'https://bot.blackturtle.eu/api'
    end
  end
end
