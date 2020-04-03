module Cryptoexchange::Exchanges
  module Hoo
    class Market < Cryptoexchange::Models::Market
      NAME = 'hoo'
      API_URL = 'https://api.hoo.com/open/v1'

      def self.trade_page_url(args={})
        "https://hoo.com/trade/#{args[:base].downcase}-#{args[:target].downcase}"
      end
    end
  end
end
