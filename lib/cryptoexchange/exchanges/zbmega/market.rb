module Cryptoexchange::Exchanges
  module Zbmega
    class Market < Cryptoexchange::Models::Market
      NAME='zbmega'
      API_URL = 'https://www.zbm.com/api/v1/ticker/all'

      def self.trade_page_url(args={})
        "https://www.zbm.com/en/#/n/trade/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
