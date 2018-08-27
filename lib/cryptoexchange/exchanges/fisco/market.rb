module Cryptoexchange::Exchanges
  module Fisco
    class Market < Cryptoexchange::Models::Market
      NAME = 'fisco'
      API_URL = 'https://api.fcce.jp/api/1'

      def self.trade_page_url(args={})
        "https://fcce.jp/trade_#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
