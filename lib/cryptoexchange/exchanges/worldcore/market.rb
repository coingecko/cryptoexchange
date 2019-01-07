module Cryptoexchange::Exchanges
  module Worldcore
    class Market < Cryptoexchange::Models::Market
      NAME = 'worldcore'
      API_URL = 'https://api.worldcore.trade'

      def self.trade_page_url(args={})
        "https://worldcore.trade/exchange/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
