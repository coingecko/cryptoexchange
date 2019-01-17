module Cryptoexchange::Exchanges
  module Abcc
    class Market < Cryptoexchange::Models::Market
      NAME    = 'abcc'
      API_URL = 'https://api.abcc.com/api/v2'
      class << self
        def trade_page_url(args = {})
          "https://abcc.com/markets/#{args[:base]}#{args[:target]}"
        end

        def separate_symbol(pair)
          separator = /(USDT|BTC|ETH)\z/i =~ pair
          base      = pair[0..separator - 1]
          target    = pair[separator..-1]
          [base, target]
        end
      end
    end
  end
end
