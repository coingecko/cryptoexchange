module Cryptoexchange::Exchanges
  module Bitalong
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitalong'
      API_URL = 'https://www.bitalong.com/api'

      def self.trade_page_url(args={})
        "https://www.bitalong.com/trade/index/market/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
