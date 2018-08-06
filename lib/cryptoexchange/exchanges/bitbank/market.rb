module Cryptoexchange::Exchanges
  module Bitbank
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitbank'
      API_URL = 'https://public.bitbank.cc'

      def self.trade_page_url(args={})
        "https://bitbank.cc/app/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
