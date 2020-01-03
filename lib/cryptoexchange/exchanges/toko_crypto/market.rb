module Cryptoexchange::Exchanges
  module TokoCrypto
    class Market < Cryptoexchange::Models::Market
      NAME = 'toko_crypto'
      API_URL = 'https://api.tokocrypto.com/v1'

      def self.trade_page_url(args={})
        "https://www.tokocrypto.com/id/dashboard/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
