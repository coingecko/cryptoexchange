module Cryptoexchange::Exchanges
  module Lukki
    class Market < Cryptoexchange::Models::Market
      NAME = 'lukki'
      API_URL = 'https://tva.lukki.io'

      def self.trade_page_url(args={})
        "https://app.lukki.io/?pair=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
