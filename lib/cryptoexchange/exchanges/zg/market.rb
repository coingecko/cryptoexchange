module Cryptoexchange::Exchanges
  module Zg
    class Market < Cryptoexchange::Models::Market
      NAME = 'zg'
      API_URL = 'https://www.zg.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.zg.com/exchange?coin=#{args[:base]}_#{args[:target]}&tab=all"
      end
    end
  end
end


