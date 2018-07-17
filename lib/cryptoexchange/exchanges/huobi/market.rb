module Cryptoexchange::Exchanges
  module Huobi
    class Market < Cryptoexchange::Models::Market
      NAME = 'huobi'
      DOT_PRO_API_URL = 'https://api.huobi.pro'

      def self.trade_page_url(args={})
        "https://www.huobi.pro/#{args[:base]}_#{args[:target]}/exchange/"
      end
    end
  end
end
