module Cryptoexchange::Exchanges
  module BitcoinIndonesia
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitcoin_indonesia'
      API_URL = 'https://vip.bitcoin.co.id/api'

      def self.trade_page_url(args={})
        "https://indodax.com/market/#{args[:base].upcase}#{args[:target].upcase}"
      end
    end
  end
end
