module Cryptoexchange::Exchanges
  module Mandala
    class Market < Cryptoexchange::Models::Market
      NAME = 'mandala'
      API_URL = 'https://zapi.mandalaex.com'

      def self.trade_page_url(args={})
      	"https://trade.mandalaex.com/trade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
