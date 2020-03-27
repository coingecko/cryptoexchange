module Cryptoexchange::Exchanges
  module Btcmex
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcmex'
      API_URL = 'https://www.btcmex.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.btcmex.com/app/transaction/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
