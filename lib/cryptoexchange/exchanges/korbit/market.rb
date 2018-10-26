module Cryptoexchange::Exchanges
  module Korbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'korbit'
      API_URL = 'https://api.korbit.co.kr/v1'

      def self.trade_page_url(args={})
        "https://www.korbit.co.kr"
      end
    end
  end
end
