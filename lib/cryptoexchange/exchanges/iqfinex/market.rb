module Cryptoexchange::Exchanges
  module Iqfinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'iqfinex'
      API_URL = 'https://datacenter.iqfinex.com'

      def self.trade_page_url(args={})
        "https://www.iqfinex.com/classic/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
