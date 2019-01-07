module Cryptoexchange::Exchanges
    module Cointeb
      class Market < Cryptoexchange::Models::Market
        NAME = 'cointeb'
        API_URL = 'https://www.cointeb.com/api/v1'
  
        def self.trade_page_url(args={})
          "https://www.cointeb.com/trade?symbol=#{args[:base]}%2F#{args[:target]}"
        end
      end
    end
  end
