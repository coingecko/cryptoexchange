module Cryptoexchange::Exchanges
  module Huobi
    class Market < Cryptoexchange::Models::Market
      NAME = 'huobi'
      DOT_PRO_API_URL = 'https://api.huobi.pro'

      def self.trade_page_url(args={})
        "https://www.hbg.com/en-us/exchange/?s=#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
