module Cryptoexchange::Exchanges
  module Bitkop
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitkop'
      API_URL = 'https://apiv2.bitkop.com/Market'

      def self.trade_page_url(args={})
        "https://www.bitkop.com/exchange/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
