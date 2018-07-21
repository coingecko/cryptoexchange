module Cryptoexchange::Exchanges
  module Bitliber
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitliber'
      API_URL = 'https://bitliber.com/api/v1'

      def self.trade_page_url(args={})
        "https://bitliber.com/markets/#{args[:base].downcase}-#{args[:target].downcase}"
      end
    end
  end
end
