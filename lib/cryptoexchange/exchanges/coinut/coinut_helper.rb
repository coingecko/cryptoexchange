module CoinutHelper
  # inst_id is used by the api to refer to a certain pair (e.g. inst_id = 1 is LTC/BTC )
  
  def prepare_and_send_request(inst_id = false, order_book = false, trade = false)
    #retrieve user's credentials
    username, api_key = retrieve_auth_credentials
    payload = generate_payload(inst_id, order_book, trade)
    hmac_hex = generate_signature(api_key, payload)
    headers = generate_headers(username, hmac_hex)
    # send the request to coinut's api with appropriate signature, headers and payload
    output = 
      if inst_id && order_book
        fetch_using_post(order_book_url, payload, headers)
      elsif inst_id
        fetch_using_post(ticker_url, payload, headers)
      else
        fetch_via_api_using_post(self.class::PAIRS_URL, headers, payload)
      end
  end

  def generate_signature(api_key, payload)
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), api_key, payload)
  end

  def retrieve_auth_credentials
    auth_credentials = YAML.load_file(auth_details_path)["coinut"]
    return auth_credentials["username"], auth_credentials["key"]
  end

  def generate_nonce
    SecureRandom.random_number(99999)
  end

  def generate_headers(username, hmac_hex)
    {"X-USER" => username, "X-SIGNATURE" => hmac_hex}
  end  

  def generate_payload(inst_id, order_book, trade)
    if inst_id && order_book
      generate_order_book_payload(inst_id)
    elsif inst_id && trade
      generate_trade_payload(inst_id)
    elsif inst_id 
      generate_ticker_payload(inst_id)
    else
      generate_pair_payload
    end
  end

  def generate_order_book_payload(inst_id)
    '{"nonce":' + generate_nonce.to_s + ',"request":"inst_order_book", "inst_id":' + inst_id + ', "top_n": 200, "decimal_places": 2 }'
  end

  def generate_trade_payload(inst_id)
    '{"nonce":' + generate_nonce.to_s + ',"request":"inst_trade", "inst_id":' + inst_id + ' }'
  end

  def generate_ticker_payload(inst_id)
    '{"nonce":' + generate_nonce.to_s + ',"request":"inst_tick", "inst_id":' + inst_id + ' }'
  end

  def generate_pair_payload(inst_id = false, order = false)
    '{"nonce":' + generate_nonce.to_s + ',"request":"inst_list", "sec_type":"SPOT"}'
  end

end