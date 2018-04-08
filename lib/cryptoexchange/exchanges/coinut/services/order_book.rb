module Cryptoexchange::Exchanges
  module Coinut
    module Services
      class OrderBook < Cryptoexchange::Services::Market
        class << self
          def supports_individual_ticker_query?
            true
          end
        end
        def fetch(market_pair)
          username, api_key = retrieve_auth_credentials
          output = prepare_and_send_request(username, api_key, market_pair)
          adapt(output, market_pair)
        end

        def order_book_url
          "#{Cryptoexchange::Exchanges::Coinut::Market::API_URL}"
        end

        def adapt(output, market_pair)
          order_book = Cryptoexchange::Models::OrderBook.new
          timestamp = Time.now.to_i
          order_book.base      = market_pair.base
          order_book.target    = market_pair.target
          order_book.market    = Coinut::Market::NAME
          order_book.asks      = adapt_orders(output["sell"])
          order_book.bids      = adapt_orders(output["buy"])
          order_book.timestamp = Time.now.to_i
          order_book.payload   = output
          order_book
        end

        def adapt_orders(orders)
          orders.collect do |order_entry|
            Cryptoexchange::Models::Order.new(price: order_entry["price"],
                                              amount: order_entry["qty"],
                                              timestamp: nil)
          end

        end

        private

        def prepare_and_send_request(username, api_key, market_pair)
          payload = generate_payload(market_pair.inst_id)
          hmac_hex = generate_signature(api_key, payload)
          headers = generate_headers(username, hmac_hex)
          output = fetch_using_post(order_book_url, payload, headers)
        end

        def generate_payload(market_pair_id)
          '{"nonce":' + generate_nonce.to_s + ',"request":"inst_order_book", "inst_id":' + market_pair_id + ', "top_n": 200, "decimal_places": 2 }'
        end

        def generate_signature(api_key, payload)
          OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), api_key, payload)
        end

        def generate_headers(username, hmac_hex)
          {"X-USER" => username, "X-SIGNATURE" => hmac_hex}
        end 

        def retrieve_auth_credentials
          auth_credentials = YAML.load_file(auth_details_path)
          return auth_credentials[:username], auth_credentials[:api_key]
        end

        def exchange_class
          exchange_name = self.class.name.split('::')[2]
          Object.const_get "Cryptoexchange::Exchanges::#{exchange_name}::Market"
        end

        def auth_details_path
          "config/cryptoexchange/#{exchange_class::NAME}_auth.yml"
        end

        def generate_nonce
          SecureRandom.random_number(99999)
        end
      end
    end
  end
end
