module Cryptoexchange::Exchanges
  module Satoexchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'satoexchange'
      API_URL = 'https://www.satoexchange.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.satoexchange.com/market/#{args[:base]}/#{args[:target]}/"
      end
    end
  end
end
