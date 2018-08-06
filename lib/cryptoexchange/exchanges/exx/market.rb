module Cryptoexchange::Exchanges
  module Exx
    class Market < Cryptoexchange::Models::Market
      NAME = 'exx'
      API_URL = 'https://api.exx.com/data/v1'

      def self.trade_page_url(args={})
        "https://www.exx.com/tradePros/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
