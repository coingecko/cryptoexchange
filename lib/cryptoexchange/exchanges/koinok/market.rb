module Cryptoexchange::Exchanges
  module Koinok
    class Market < Cryptoexchange::Models::Market
      NAME = 'koinok'
      API_URL = 'https://www.koinok.com/api/brain'

      def self.trade_page_url(args={})
        "https://www.koinok.com/exchange/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
