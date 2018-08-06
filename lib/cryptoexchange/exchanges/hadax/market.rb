module Cryptoexchange::Exchanges
  module Hadax
    class Market < Cryptoexchange::Models::Market
      NAME = 'hadax'
      PAIRS_API_URL = 'https://api.huobi.pro/v1/hadax/common/symbols'
      API_URL = 'https://api.hadax.com'

      def self.trade_page_url(args={})
        "https://www.hadax.com/#{args[:base]}_#{args[:target]}/exchange/"
      end
    end
  end
end
