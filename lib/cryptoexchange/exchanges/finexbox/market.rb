module Cryptoexchange::Exchanges
  module Finexbox
    class Market < Cryptoexchange::Models::Market
      NAME = 'finexbox'
      API_URL = 'https://xapi.finexbox.com/v1'

      def self.trade_page_url(args={})
        "https://www.finexbox.com/Home/Orders/market/pair/#{args[:base]}-#{args[:target]}.html"
      end
    end
  end
end
