module Cryptoexchange::Exchanges
  module Tokpie
    class Market < Cryptoexchange::Models::Market
      NAME = 'tokpie'
      API_URL = 'https://tokpie.com'

      def self.trade_page_url(args={})
        "https://tokpie.com/view_exchange/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
