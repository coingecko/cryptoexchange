module Cryptoexchange::Exchanges
  module GmoJapan
    class Market < Cryptoexchange::Models::Market
      NAME    = 'gmo_japan'
      API_URL = 'https://api.coin.z.com/public/v1'
      def self.trade_page_url(args={})
        "https://coin.z.com/jp/corp/information/#{args[:base].downcase}-market/"
      end
    end
  end
end
