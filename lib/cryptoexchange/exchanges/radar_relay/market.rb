module Cryptoexchange::Exchanges
  module RadarRelay
    class Market < Cryptoexchange::Models::Market
      NAME = 'radar_relay'
      API_URL = 'https://api.radarrelay.com/v0'
    end
  end
end
