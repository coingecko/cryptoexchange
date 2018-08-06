module Cryptoexchange::Exchanges
  module Lbank
    class Market < Cryptoexchange::Models::Market
      NAME = 'lbank'
      API_URL = 'https://api.lbank.info/v1'

      def self.trade_page_url(args={})
        "https://www.lbank.info/exchange.html?asset=#{args[:base].downcase}&post=#{args[:target].downcase}"
      end
    end
  end
end
