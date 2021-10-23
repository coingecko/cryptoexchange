module Cryptoexchange::Exchanges
  module Eterbase
    class Market < Cryptoexchange::Models::Market
      NAME='eterbase'
      API_URL = 'https://api.eterbase.exchange/api'

      def self.trade_page_url(args={})
        "https://eterbase.exchange/markets/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
