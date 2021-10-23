module Cryptoexchange::Exchanges
  module Bitcratic
    class Market < Cryptoexchange::Models::Market
      NAME='bitcratic'
      API_URL = "https://www.bitcratic"

      def self.trade_page_url(args={})
        "https://www.bitcratic.com/#!/trade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
