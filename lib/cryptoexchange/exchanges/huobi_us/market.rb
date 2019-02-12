module Cryptoexchange::Exchanges
  module HuobiUs
    class Market < Cryptoexchange::Models::Market
      NAME = 'huobi_us'
      DOT_PRO_API_URL = 'https://api.huobi.com'

      def self.trade_page_url(args={})
        "https://www.huobi.com/#{args[:base]}_#{args[:target]}/exchange/"
      end
    end
  end
end
