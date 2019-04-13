module Cryptoexchange::Exchanges
  module Exx
    class Market < Cryptoexchange::Models::Market
      NAME = 'exx'
      API_URL = 'https://api.exx.com/data/v1'

      def self.trade_page_url(args={})
        pair = "#{args[:base]}_#{args[:target]}".downcase
        "https://www.exx.com/tradeCoding/#{pair}"
      end
    end
  end
end
