module Cryptoexchange::Exchanges
  module Ccx
    class Market < Cryptoexchange::Models::Market
      NAME = 'ccx'
      API_URL = 'https://manager.ccxcanada.com/api/v2'
      
      def self.trade_page_url(args={})
        "https://ccxcanada.com/markets/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
