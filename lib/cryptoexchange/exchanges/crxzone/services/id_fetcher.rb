module Cryptoexchange::Exchanges
  module Crxzone
    module Services
      class IdFetcher
        def self.get_id(base, target)
          pairs_response = HTTP.get(Cryptoexchange::Exchanges::Crxzone::Services::Pairs::PAIRS_URL)
          pairs_result = pairs_response.parse(:json)['Result']
          pairs_result.select { |s| s['PrimaryCurrencyCode'] == base && s['SecondaryCurrencyName'] == target }
        end
      end
    end
  end
end
