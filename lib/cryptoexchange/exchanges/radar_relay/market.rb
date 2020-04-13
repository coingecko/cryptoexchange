module Cryptoexchange::Exchanges
  module RadarRelay
    class Market < Cryptoexchange::Models::Market
      NAME = 'radar_relay'
      API_URL = 'https://api.radarrelay.com/v3'

      def self.trade_page_url(args={})
        "https://app.radarrelay.com/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
