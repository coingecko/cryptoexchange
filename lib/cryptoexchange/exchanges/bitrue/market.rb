module Cryptoexchange::Exchanges
  module Bitrue
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitrue'
      API_URL = 'https://www.bitrue.com'


      def self.trade_page_url(args={})
        base = args[:base].downcase
        target = args[:target].downcase
        "https://www.bitrue.com/trading?market=#{target}&symbol=#{base}#{target}"
      end
    end
  end
end
