module Cryptoexchange::Exchanges
  module HuobiDm
    class Market < Cryptoexchange::Models::Market
      NAME = 'huobi_dm'
      API_URL = 'https://api.hbdm.com'

      def self.trade_page_url(args={})
        "https://dm.huobi.com/en-us"
      end
    end
  end
end
