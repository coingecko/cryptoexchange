module Cryptoexchange::Exchanges
  module SatoWalletEx
    class Market < Cryptoexchange::Models::Market
      NAME = 'sato_wallet_ex'
      API_URL = 'https://satowallet.com/Api'

      def self.trade_page_url(args={})
        "https://satowallet.com/trade/index/market/#{args[:base]}_#{args[:target]}/"
      end
    end
  end
end
