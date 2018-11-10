module Cryptoexchange::Exchanges
  module Allbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'allbit'
      API_URL = 'https://allbit.com/api'

      def self.trade_page_url(args = {})
        "https://allbit.com/exchange/#{args[:base]}"
      end
    end
  end
end
