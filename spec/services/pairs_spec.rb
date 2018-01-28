require 'spec_helper'

RSpec.describe Cryptoexchange::Services::Pairs do
  let(:pairs) { Cryptoexchange::Services::Pairs.new }

  it 'fetches with API if PAIRS_URL exists' do
    stub_const("Cryptoexchange::Services::Pairs::PAIRS_URL", "https://www.someurls.com")
    allow(HTTP).to receive(:timeout).and_return(HTTP)
    allow(HTTP).to receive(:get).and_return(HTTP::Response.new(status: 200, body: {}, version: '1.1'))
    pairs.fetch
    expect(HTTP).to have_received(:get)
  end

  it 'fetches with default_override_path if no user override exists' do
    allow(pairs).to receive(:user_override_exist?).and_return false
    allow(pairs).to receive(:default_override_exist?).and_return true
    allow(pairs).to receive(:user_override_path).and_return '/path/to/user_override.yml'
    allow(pairs).to receive(:default_override_path).and_return '/path/to/default_override.yml'
    allow(YAML).to receive(:load_file).and_return({ pairs: []})
    pairs.fetch
    expect(YAML).to have_received(:load_file).with('/path/to/default_override.yml')
  end

  it 'fetches with user_override_path if exists' do
    allow(pairs).to receive(:user_override_exist?).and_return true
    allow(pairs).to receive(:user_override_path).and_return '/path/to/user_override.yml'
    allow(YAML).to receive(:load_file).and_return({ pairs: []})
    pairs.fetch
    expect(YAML).to have_received(:load_file).with('/path/to/user_override.yml')
  end

  context 'error propagation' do
    let(:market) { Cryptoexchange::Services::Market.new }

    it 'throws Cryptoexchange::HttpResponseError' do
      expect(market).to receive(:http_get).with('http://someendpoint.com') { HTTP::Response.new(status: 500, body: {}, version: '1.1') }
      expect{ market.fetch('http://someendpoint.com') }.to raise_error(Cryptoexchange::HttpResponseError)
    end

    it 'throws Cryptoexchange::HttpConnectionError' do
      expect(market).to receive(:http_get).with('http://someendpoint.com') { raise HTTP::ConnectionError }
      expect{ market.fetch('http://someendpoint.com') }.to raise_error(Cryptoexchange::HttpConnectionError)
    end

    it 'throws Cryptoexchange::HttpTimeoutError' do
      expect(market).to receive(:http_get).with('http://someendpoint.com') { raise HTTP::TimeoutError }
      expect{ market.fetch('http://someendpoint.com') }.to raise_error(Cryptoexchange::HttpTimeoutError)
    end

    it 'throws Cryptoexchange::JsonParseError' do
      expect(market).to receive(:http_get).with('http://someendpoint.com') { raise JSON::ParserError }
      expect{ market.fetch('http://someendpoint.com') }.to raise_error(Cryptoexchange::JsonParseError)
    end

    it 'throws Cryptoexchange::TypeFormatError' do
      expect(market).to receive(:http_get).with('http://someendpoint.com') { raise TypeError }
      expect{ market.fetch('http://someendpoint.com') }.to raise_error(Cryptoexchange::TypeFormatError)
    end
  end
end
