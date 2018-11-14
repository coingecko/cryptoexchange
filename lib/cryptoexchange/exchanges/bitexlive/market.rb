module Cryptoexchange::Exchanges
  module Bitexlive
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitexlive'
      API_URL = 'https://bitexlive.com/api'

      def self.trade_page_url(args={})
        "https://bitexlive.com/exchange/#{args[:target]}-#{args[:base]}"
      end
    end
  end
end
