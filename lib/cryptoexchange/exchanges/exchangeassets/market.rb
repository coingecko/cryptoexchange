module Cryptoexchange::Exchanges
  module Exchangeassets
    class Market < Cryptoexchange::Models::Market
      NAME = 'exchangeassets'
      API_URL = 'https://exchange-assets.com/api/public'

      def self.trade_page_url(args={})
        "https://exchange-assets.com/ru/?market=#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
