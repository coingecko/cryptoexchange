module Cryptoexchange::Exchanges
  module Switcheo
    class Market < Cryptoexchange::Models::Market
      NAME = 'switcheo'
      API_URL = 'https://api.switcheo.network'
    end

    def self.trade_page_url(args={})
      "https://switcheo.exchange/markets/#{args[:base]}_#{args[:target]}"
    end
  end
end
