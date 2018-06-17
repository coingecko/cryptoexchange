module Cryptoexchange::Exchanges
  module Joyso
    module Services
      class IdFetcher
        def self.get_id(base)
          tokens = HTTP.get("#{Cryptoexchange::Exchanges::Joyso::Market::API_URL}/system")
          pairs_result = tokens.parse(:json)
          base_token = pairs_result['tokens'].select { |s| s['symbol'] == base }
          base_token[0]['address']
        end
      end
    end
  end
end
