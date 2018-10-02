module Cryptoexchange::Exchanges
  module Wazirx
    class Market < Cryptoexchange::Models::Market
      NAME = 'wazirx'
      API_URL = 'https://api.wazirx.com/api/v2'
      API_URL2 = 'https://x.wazirx.com/api/v2'
    end
  end
end
