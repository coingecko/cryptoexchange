module Cryptoexchange::Exchanges
  module Deribit
    class Market < Cryptoexchange::Models::Market
      NAME = 'deribit'
      API_URL = 'https://www.deribit.com/api/v2/public'

      def self.trade_page_url(args={})
        "https://www.deribit.com/main#/futures?tab=#{args[:base]}-PERPETUAL"
      end
    end
  end
end
