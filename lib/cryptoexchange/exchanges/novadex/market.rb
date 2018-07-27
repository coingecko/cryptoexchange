module Cryptoexchange::Exchanges
  module Novadex
    class Market < Cryptoexchange::Models::Market
      NAME = 'novadex'
      API_URL = 'https://novadex.io'

      def self.trade_page_url(args={})
        "https://www.novadex.io/user_trade.php?ekind=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
