module Cryptoexchange::Exchanges
  module Coinroom
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        TICKER_URL = "#{Cryptoexchange::Exchanges::Coinroom::Market::API_URL}/ticker"
        AVAILABLE_CURRENCIES = "#{Cryptoexchange::Exchanges::Coinroom::Market::API_URL}/availableCurrencies"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: pair[:base],
                              target: pair[:target],
                              market: Coinroom::Market::NAME
                            )
          end
          market_pairs
        end

        private
        
        #call this method to retrieve and write pairs to coinroom.yml file
        def retrieve_new_pairs
          all_currencies = fetch_via_api(AVAILABLE_CURRENCIES)
          find_and_write_all_possible_pairs(all_currencies)
        end

        #finds all the possible pairs by continually querying coinroom api with different currencies and then  write it into the yml file
        def find_and_write_all_possible_pairs(all_currencies)
          fiat_currency, crypto_currency = all_currencies["real"], all_currencies["crypto"]
          create_new_yml_file
          fiat_currency.each do |fiat|
            crypto_currency.each do |crypto|
              response = query_ticker_api_with("/#{crypto}/#{fiat}")
              add_pairs_to_yml(crypto, fiat) unless empty_values?(response) 
            end
          end
        end

        def query_ticker_api_with(query_string)
          fetch_via_api(TICKER_URL + query_string)
        end

        #writes the found currency pair to the yml file
        def add_pairs_to_yml(crypto, fiat)
          File.open(Dir.pwd + "/lib/cryptoexchange/exchanges/coinroom/coinroom.yml", "a+") do |file|
            file.write("  - :base: #{crypto}\n")
            file.write("    :target: #{fiat}\n")
          end
        end

        def create_new_yml_file
          File.open(Dir.pwd + "/lib/cryptoexchange/exchanges/coinroom/coinroom.yml", "w+") do |file|
            file.write(":pairs:\n")
          end
        end

        #checks if all the values for a response is 0
        def empty_values?(ticker)
          ticker.values.all? {|x| x == 0}
        end

      end
    end
  end
end
