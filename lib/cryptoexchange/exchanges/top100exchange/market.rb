module Cryptoexchange::Exchanges
  module Top100exchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'top100exchange'
      API_URL = 'https://member.top100exchange.co.uk/API.svc'
    end
  end
end
