module Cryptoexchange::Exchanges
  module Blokmy
    class Market < Cryptoexchange::Models::Market
      NAME    = 'blokmy'
      API_URL = 'https://blokmy.com/api/v2'

      def self.trade_page_url(args = {})
        base   = args[:base].downcase
        target = args[:target].downcase
        "https://blokmy.com/markets/#{base}#{target}"
      end
    end
  end
end
