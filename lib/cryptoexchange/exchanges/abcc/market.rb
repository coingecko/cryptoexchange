module Cryptoexchange::Exchanges
  module Abcc
    class Market < Cryptoexchange::Models::Market
      NAME    = 'abcc'
      API_URL = 'https://api.abcc.com/api/v2'
      class << self
        def trade_page_url(args = {})
          "https://abcc.com/markets/#{args[:base].downcase}#{args[:target].downcase}"
        end

        def separate_symbol(pair)
          separator = /(USDT|BTC|ETH|TRX)\z/i =~ pair
          base      = pair[0..separator - 1]
          target    = pair[separator..-1]
          [base, target]
        rescue NoMethodError
          nil
        end
      end
    end
  end
end
