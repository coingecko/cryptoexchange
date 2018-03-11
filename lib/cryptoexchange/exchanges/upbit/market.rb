module Cryptoexchange::Exchanges
  module Upbit
    class Market
      NAME = 'upbit'
      API_URL = 'https://crix-api-endpoint.upbit.com/v1/crix/candles'
      PAIRS_URL = 'https://s3.ap-northeast-2.amazonaws.com/crix-production/crix_master'
    end
  end
end
