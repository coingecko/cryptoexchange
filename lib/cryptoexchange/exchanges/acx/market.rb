module Cryptoexchange::Exchanges
  module Acx
    class Market < Cryptoexchange::Models::Market
      NAME = 'acx'
      API_URL = 'https://acx.io/api/v2'

      def self.trade_page_url(args={})
        "https://acx.io/markets/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
