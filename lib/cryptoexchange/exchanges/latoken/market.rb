module Cryptoexchange::Exchanges
  module Latoken
    class Market < Cryptoexchange::Models::Market
      NAME = 'latoken'
      API_URL = 'https://api.latoken.com'

      def self.trade_page_url(args={})
        "https://wallet.latoken.com/market/Crypto/#{args[:target]}/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
