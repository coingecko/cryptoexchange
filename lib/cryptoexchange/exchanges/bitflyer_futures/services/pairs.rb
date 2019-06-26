module Cryptoexchange::Exchanges
  module BitflyerFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::BitflyerFutures::Market::API_URL}/markets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |value|
            data = get_valid_futures_product_code(value)
            next if data[:base].nil?
            base, target = data[:base], data[:target]
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              contract_interval: data[:contract_interval],
                              market: BitflyerFutures::Market::NAME
                            )
          end.compact

          market_pairs
        end

        def get_valid_futures_product_code(value)
          if value['alias'].nil? && value['product_code'].include?("FX")
            product_code = value['product_code']
            base, target = product_code.split('_').delete_if { |x| x == "FX" }
            contract_interval = "perpetual"
          elsif value['alias'] != nil
            contract_interval_list = { "MAT1WK" => "weekly", "MAT3M" => "quarterly", "MAT2WK" => "biweekly" }
            base, target = "BTC", "JPY"
            contract_interval_code = value['alias'].split('_')[1]
            contract_interval = contract_interval_list[contract_interval_code]
          end
          { "base": base, "target": target, "contract_interval": contract_interval }
        end
      end
    end
  end
end
