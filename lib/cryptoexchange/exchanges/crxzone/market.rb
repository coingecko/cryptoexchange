module Cryptoexchange::Exchanges
  module Crxzone
    class Market < Cryptoexchange::Models::Market
      NAME = 'crxzone'
      API_URL = 'https://www.crxzone.com/API'

      def self.trade_page_url(args={})
        "https://www.crxzone.com/services/trade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
