module Cryptoexchange::Exchanges
  module Probit
    class Market < Cryptoexchange::Models::Market
      NAME = 'probit'
      API_URL = 'https://api.probit.com/api/exchange/v1'

      def self.trade_page_url(args={})
        "https://www.probit.com/app/exchange/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
