module Cryptoexchange::Exchanges
  module Idex
    class Market < Cryptoexchange::Models::Market
      NAME = 'idex'
      API_URL = 'https://api.idex.market'

      def self.trade_page_url(args={})
        "https://idex.market/#{args[:target]}/#{args[:base]}"
      end
    end
  end
end
