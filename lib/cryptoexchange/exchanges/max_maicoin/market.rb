module Cryptoexchange::Exchanges
  module MaxMaicoin
    class Market
      NAME = 'max_maicoin'
      API_URL = 'https://max-api.maicoin.com/api/v2'

      def self.trade_page_url(args={})
        "https://max.maicoin.com/markets/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
