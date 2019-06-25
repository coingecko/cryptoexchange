module Cryptoexchange::Exchanges
  module Oex
    class Market < Cryptoexchange::Models::Market
      NAME = 'oex'
      API_URL = 'https://openapi.oex.com/open/api'

      def self.trade_page_url(args={})
        "https://www.oex.com/trade/#{args[:base]}_#{args[:target]}"
      end

      def self.separate_symbol(pair)
          separator = /(BTC|ETH|EOS|OEX|BCH|LTC|ETC|NEO|TRX|GOD|FTC|CTC|BTO|1SG|GCN|RXTBC|CSE|APL|XET|HFR|EDR|EVY|S|INB|BNB|HT|BIX|ZB|FT|KCS|MVC|BTNT|QUB|PGTS|IIC|USDT)\z/i =~ pair
          base      = pair[0..separator - 1]
          target    = pair[separator..-1]
          [base, target]
      rescue NoMethodError
          nil
      end      
    end
  end
end
