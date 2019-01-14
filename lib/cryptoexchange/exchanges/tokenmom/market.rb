module Cryptoexchange::Exchanges
  module Tokenmom
    class Market < Cryptoexchange::Models::Market
      NAME = 'tokenmom'
      DOT_PRO_API_URL = 'https://api.tokenmom.com'

      def self.trade_page_url(args={})
        "https://www.tokenmom.com/exchange/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
