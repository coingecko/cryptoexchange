module Cryptoexchange::Exchanges
  module Yobit
    class Market < Cryptoexchange::Models::Market
      NAME = 'yobit'
      API_URL = 'https://yobit.net/api/3'

      def self.trade_page_url(args={})
        "https://yobit.net/en/trade/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
