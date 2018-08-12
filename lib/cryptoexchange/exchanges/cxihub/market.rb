module Cryptoexchange::Exchanges
  module Cxihub
    class Market < Cryptoexchange::Models::Market
      NAME = 'cxihub'
      API_URL = 'https://api.cxihub.com'
    end

    def self.trade_page_url(args={})
      "https://www.cxihub.com/app/market?market=#{args[:target]}/#{args[:base]}"
    end
  end
end
