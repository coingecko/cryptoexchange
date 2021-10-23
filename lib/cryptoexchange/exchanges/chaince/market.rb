module Cryptoexchange::Exchanges
  module Chaince
    class Market < Cryptoexchange::Models::Market
      NAME = 'chaince'
      API_URL = 'https://api.chaince.com'

      def self.trade_page_url(args={})
        "https://chaince.com/trade/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
