require 'spec_helper'

RSpec.describe Cryptoexchange::Services::Account do
  let(:account) { Cryptoexchange::Services::Account.new }
  context 'fetch account info' do
    it 'calls the HTTP POST and get the account return DepositAddresses' do
      allow(account).to receive(:http_post).and_return('{"BTC": "btcaddress", "LTC": "ltcaddress"}')
      expect(account).to receive(:http_post).once
      account.fetch('https://api.something.com', {key: "api_key", sign: "api_sign"}, {command: "command", nonce: "123"})
    end

    it 'receive config use default settings path' do
      allow(account).to receive(:user_settings_exist?).and_return false
      allow(account).to receive(:default_settings_path).and_return 'path/to/default_settings.yml'
      allow(YAML).to receive(:load_file).and_return(api: { key: "api_key", sign: "api_sign" })
      account.config_setup
      expect(YAML).to have_received(:load_file).with('path/to/default_settings.yml')
    end

    it 'receive config use user settings path' do
      allow(account).to receive(:user_settings_exist?).and_return true
      allow(account).to receive(:user_settings_path).and_return 'path/to/user_settings.yml'
      allow(YAML).to receive(:load_file).and_return(api: { key: "api_key", sign: "api_sign" })
      account.config_setup
      expect(YAML).to have_received(:load_file).with('path/to/user_settings.yml')
    end
  end
end
