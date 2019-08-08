module Cryptoexchange::Exchanges
  module Bitsonic
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitsonic'
      API_URL = 'https://open-api.bitsonic.co.kr/api'

      def self.trade_page_url(args={})
        "https://bitsonic.co.kr/front/en/exchange/#{args[:base].downcase}-#{args[:target].downcase}"
      end
    end
  end
end
