module Cryptoexchange::Exchanges
  module Zaif
    class Market < Cryptoexchange::Models::Market
      NAME = 'zaif'
      API_URL = 'https://api.zaif.jp/api/1'

      def self.trade_page_url(args={})
        "https://zaif.jp/trade_#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
