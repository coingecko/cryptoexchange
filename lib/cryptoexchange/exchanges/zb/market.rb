module Cryptoexchange::Exchanges
  module Zb
    class Market < Cryptoexchange::Models::Market
      NAME = 'zb'
      API_URL = 'http://api.zb.com/data/v1'

      def self.trade_page_url(args={})
        "https://trans.zb.com/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
