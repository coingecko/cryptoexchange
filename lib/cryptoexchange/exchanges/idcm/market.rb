module Cryptoexchange::Exchanges
  module Idcm
    class Market < Cryptoexchange::Models::Market
      NAME = 'idcm'
      API_URL = 'http://api.idcm.io:8303/api/v1'

      def self.trade_page_url(args={})
        "https://www.idcm.io/trading/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
