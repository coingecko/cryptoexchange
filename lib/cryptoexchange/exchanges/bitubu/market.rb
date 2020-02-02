module Cryptoexchange::Exchanges
  module Bitubu
    class Market < Cryptoexchange::Models::Market
      NAME    = 'bitubu'
      API_URL = 'https://bitubu.com/api/v2'

      def self.trade_page_url(args = {})
        base   = args[:base].downcase
        target = args[:target].downcase
        "https://bitubu.com/trading/#{base}#{target}"
      end
    end
  end
end
