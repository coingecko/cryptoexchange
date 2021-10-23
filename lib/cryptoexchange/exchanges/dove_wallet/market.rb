module Cryptoexchange::Exchanges
  module DoveWallet
    class Market < Cryptoexchange::Models::Market
      NAME = 'dove_wallet'
      API_URL = 'https://api.dovewallet.com/v1/public'

      def self.trade_page_url(args={})
        "https://dovewallet.com/trade/spot/#{args[:base].downcase}-#{args[:target].downcase}"
      end
    end
  end
end
