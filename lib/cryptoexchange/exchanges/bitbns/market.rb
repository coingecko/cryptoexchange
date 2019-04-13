module Cryptoexchange::Exchanges
  module Bitbns
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitbns'
      API_URL = 'https://bitbns.com'

      def self.trade_page_url(args={})
        "https://bitbns.com/trade/#/#{args[:base].downcase}"
      end
    end
  end
end
