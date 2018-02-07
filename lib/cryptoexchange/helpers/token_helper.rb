module TokenHelper
  class << self
    API_URL = 'https://api.ethplorer.io/getTokenInfo'
    def get_symbol(token)
      endpoint = "#{API_URL}/#{token}?apiKey=buoc5056EEZGf105"
      LruTtlCache.token_cache.getset(endpoint) do
        response = http_get(endpoint)
        if response.code == 200
          response.parse(:json)['symbol']
        else
          raise Cryptoexchange::TokenError, { response: response }
        end
      end
    end

    private

    def http_get(endpoint)
      HTTP.timeout(:write => 2, :connect => 5, :read => 8).get(endpoint)
    end
  end
end
