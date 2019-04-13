module Cryptoexchange::Exchanges
  module Letsdocoinz
    class Market < Cryptoexchange::Models::Market
      NAME = 'letsdocoinz'
      API_URL = 'http://api.letsdocoinz.com'

      def self.trade_page_url(args={})
        "https://letsdocoinz.com/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
