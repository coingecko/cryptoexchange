module Cryptoexchange::Exchanges
  module Novaexchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'novaexchange'
      API_URL = 'https://novaexchange.com/remote/v2'

      def self.trade_page_url(args={})
        "https://novaexchange.com/market/#{args[:target]}_#{args[:base]}/"
      end
    end
  end
end
