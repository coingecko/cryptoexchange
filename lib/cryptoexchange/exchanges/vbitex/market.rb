module Cryptoexchange::Exchanges
  module Vbitex
    class Market < Cryptoexchange::Models::Market
      NAME = 'vbitex'
      API_URL = 'http://www.vbitex.com'

      def self.trade_page_url(args={})
        "http://www.vbitex.com/Home/Qcorders/index/currency/#{args[:base]}.html"
      end
    end
  end
end
