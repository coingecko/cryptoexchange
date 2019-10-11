module Cryptoexchange::Exchanges
  module UpbitIndonesia
    class Market < Cryptoexchange::Models::Market
      NAME = 'upbit_indonesia'
      API_URL = 'https://crix-api-id.upbit.com/v1/crix'

      def self.trade_page_url(args={})
        "https://id.upbit.com/exchange?code=CRIX.UPBIT.#{args[:target].upcase}-#{args[:base].upcase}"
      end
    end
  end
end
