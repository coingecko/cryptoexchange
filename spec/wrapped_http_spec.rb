require "spec_helper"

RSpec.describe WrappedHTTP do
  describe ".client" do
    context "with proxy_list (array of hashes)" do
      it "uses sample of proxy_list as proxy" do
        proxy_list = [
          {proxy_address: "1.2.3.4", proxy_port: 8080},
          {proxy_address: "5.6.7.8", proxy_port: 8080},
          {proxy_address: "9.10.11.12", proxy_port: 8080}
        ]

        Cryptoexchange.configure do |config|
          config.proxy_list = proxy_list
        end

        expect(proxy_list).to include WrappedHTTP.client.default_options.proxy
      end
    end

    context "without proxy_list (nil)" do
      it "uses {} as proxy" do
        proxy_list = nil

        Cryptoexchange.configure do |config|
          config.proxy_list = proxy_list
        end

        empty_hash = {}
        expect(WrappedHTTP.client.default_options.proxy).to eq empty_hash
      end
    end
  end
end
