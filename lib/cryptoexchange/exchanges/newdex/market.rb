module Cryptoexchange::Exchanges
  module Newdex
    class Market < Cryptoexchange::Models::Market
      NAME = 'newdex'
      API_URL = 'https://api.newdex.io'

      def self.trade_page_url(args={})
        "https://newdex.io/trade/#{args[:inst_id].downcase}-#{args[:base].downcase}-#{args[:target].downcase}"
      end
    end
  end
end
