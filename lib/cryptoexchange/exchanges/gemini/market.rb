module Cryptoexchange::Exchanges
  module Gemini
    class Market < Cryptoexchange::Models::Market
      NAME = 'gemini'
      API_URL = 'https://api.gemini.com/v1'
    end
  end
end
