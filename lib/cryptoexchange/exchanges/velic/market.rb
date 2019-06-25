module Cryptoexchange::Exchanges
  module Velic
    class Market < Cryptoexchange::Models::Market
      NAME = 'velic'
      API_URL = 'https://api.velic.io/api/v1'

      def self.trade_page_url(args={})
        "https://www.velic.io/?pagename=exchange/trading&cointype=#{args[:base].upcase}/#{args[:target].upcase}"
      end
    end
  end
end
