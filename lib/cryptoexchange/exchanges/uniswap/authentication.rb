module Cryptoexchange::Exchanges
  module Uniswap
    class Authentication < Cryptoexchange::Services::Authentication
      def headers
        api_key = HashHelper.dig(Cryptoexchange::Credentials.get(@exchange), 'api_key')
      end
    end
  end
end
