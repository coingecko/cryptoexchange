module Cryptoexchange::Exchanges
  module CoinEgg
    class Market < Cryptoexchange::Models::Market
      NAME = 'coin_egg'
      API_URL = 'https://api.coinegg.im'

      def self.trade_page_url(args={})
        "https://www.coinegg.com/#{args[:target].downcase}/#{args[:base].downcase}/"
      end
    end
  end
end
