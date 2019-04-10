module Cryptoexchange::Exchanges
  module Biki
    class Market < Cryptoexchange::Models::Market
      NAME = 'biki'
      API_URL = 'https://api.biki.com/open/api'

      def self.trade_page_url(args={})
        "https://www.biki.com/trade/#{args[:base]}_#{args[:target]}"
      end

      def self.separate_symbol(pair)
          separator = /(BNB|BIX|ATT|KCS|BTT|REG|CWV|ONT|GXC|ETH|TRX|EOS|LC|TWJ|WIN|IGG|LTC|ETC|XC|BCH|MNC|888|SHE|BSV|XRP|SNT|ZIL|BLZ|ELF|ZRX|ETU|EEC|ALI|FOU|USDT|BIKI|GPEI|FET|BITCNY|DASH|USDT|BTC|BTS|ADC|SEE|ANKR|DOGE|CELR|BEI|ULAM|LPT|GOD|CVNT|BABT|TYT|MNC|HIC|ABS|ONG|TYD|ABGS|DET|SEGA|ACAR|SFIS|FTN|RRV|TOCC|PSH|EDS|AKB48|FIT|WECF|MUT|ETPC|WFEE|BZJ|WIOT|FO|HT|ZB|FT|IOST|THETA|LAMB|BATA|DICE|NFUN|ANTE|SEED|POPPY)\z/i =~ pair
          base      = pair[0..separator - 1]
          target    = pair[separator..-1]
          [base, target]
      rescue NoMethodError
          nil
      end      
    end
  end
end
