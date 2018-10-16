module Cryptoexchange::Exchanges
  module B2bx
    class Market < Cryptoexchange::Models::Market
      NAME = 'b2bx'
      API_URL = 'https://api.b2bx.exchange/api/v1/b2trade/ticker'
      SUPPORTED_PAIRS_REGEX = /(BTC$)+|(ETH$)+(.*)|(USDT$)+(.*)|(USD$)+(.*)|(EUR$)+(.*)|(BCH$)+(.*)|(DASH$)+(.*)|(XRP$)+(.*)|(XEM$)+(.*)|(OMG$)+(.*)|(XMR$)+(.*)|(LTC$)+(.*)|(ADA$)+(.*)|(B2BX$)+(.*)|(NEO$)+(.*)/
    end
  end
end
