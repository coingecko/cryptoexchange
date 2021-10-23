module Cryptoexchange::Exchanges
  module Digitalprice
    class Market < Cryptoexchange::Models::Market
      NAME    = 'digitalprice'
      API_URL = 'https://altsbit.com/api'

      def self.trade_page_url(args = {})
        base   = args[:base].downcase
        target = args[:target].downcase
        "https://altsbit.com/order?url=#{base}-#{target}"
      end
    end
  end
end
