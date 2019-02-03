module Cryptoexchange::Exchanges
  module BitZ
    class Market < Cryptoexchange::Models::Market
      NAME = 'bit_z'
      API_URL = "https://apiv2.bitz.com".freeze

      def self.trade_page_url(args={})
        "https://bit-z.com/exchange/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
