module Cryptoexchange::Exchanges
  module Btcturk
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcturk'
      API_URL = 'https://api.btcturk.com/api/v2'

      def self.trade_page_url(args={})
        "https://pro.btcturk.com/pro/al-sat/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
