module Cryptoexchange::Exchanges
  module Codex
    class Market < Cryptoexchange::Models::Market
      NAME = 'codex'
      API_URL = 'https://api.codex.one'
    end
  end
end
