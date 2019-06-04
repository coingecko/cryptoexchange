class WrappedHTTP
  def self.client
    if Cryptoexchange.configuration.proxy_list.nil?
      HTTP
    else
      proxy = Cryptoexchange.configuration.proxy_list.sample
      HTTP.via(proxy[:proxy_address], proxy[:proxy_port])
    end
  end
end
