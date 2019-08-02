require 'spec_helper'

RSpec.describe Cryptoexchange::Services::Pairs do
  let(:pairs) { Cryptoexchange::Services::Pairs.new }

  it 'fetches with API if PAIRS_URL exists' do
    stub_const("Cryptoexchange::Services::Pairs::PAIRS_URL", "https://www.someurls.com")
    allow(HTTP).to receive(:timeout).and_return(HTTP)
    allow(HTTP).to receive(:follow).and_return(HTTP)
    allow(HTTP).to receive(:use).and_return(HTTP)
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
    let(:pairs) { Cryptoexchange::Exchanges::Gdax::Services::Pairs.new }

    it 'throws Cryptoexchange::HttpResponseError' do
      expect(pairs).to receive(:http_get) { HTTP::Response.new(status: 500, body: {}, version: '1.1') }
      expect{ pairs.fetch_via_api }.to raise_error(Cryptoexchange::HttpResponseError)
    end

    it 'throws Cryptoexchange::HttpBadRequestError' do
      expect(pairs).to receive(:http_get) { HTTP::Response.new(status: 400, body: {}, version: '1.1') }
      expect{ pairs.fetch }.to raise_error(Cryptoexchange::HttpBadRequestError)
    end

    it 'throws Cryptoexchange::HttpConnectionError' do
      expect(pairs).to receive(:http_get) { raise HTTP::ConnectionError }
      expect{ pairs.fetch }.to raise_error(Cryptoexchange::HttpConnectionError)
    end

    it 'throws Cryptoexchange::HttpTimeoutError' do
      expect(pairs).to receive(:http_get) { raise HTTP::TimeoutError }
      expect{ pairs.fetch }.to raise_error(Cryptoexchange::HttpTimeoutError)
    end

    it 'throws Cryptoexchange::JsonParseError' do
      expect(pairs).to receive(:http_get) { raise JSON::ParserError }
      expect{ pairs.fetch }.to raise_error(Cryptoexchange::JsonParseError)
    end

    it 'throws Cryptoexchange::TypeFormatError' do
      expect(pairs).to receive(:http_get) { raise TypeError }
      expect{ pairs.fetch }.to raise_error(Cryptoexchange::TypeFormatError)
    end
  end
end
