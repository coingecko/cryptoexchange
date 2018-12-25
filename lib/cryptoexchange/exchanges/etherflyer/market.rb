module Cryptoexchange::Exchanges
  module Etherflyer
    class Market < Cryptoexchange::Models::Market
      NAME = 'Etherflyer'
      API_URL = 'https://open.etherflyer.com'

      def self.trade_page_url(args={})
        "https://www.etherflyer.com/trade.html?pairs=#{args[:base].upcase}-#{args[:target].upcase}"
      end
    end
  end
end
