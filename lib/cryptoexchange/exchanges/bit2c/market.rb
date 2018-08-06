module Cryptoexchange::Exchanges
  module Bit2c
    class Market < Cryptoexchange::Models::Market
      NAME = 'bit2c'
      API_URL = 'https://bit2c.co.il'

      def self.trade_page_url(args={})
        "https://bit2c.co.il/order?pair=#{args[:base]}#{args[:target]}"
      end
    end
  end
end
