require 'spec_helper'

RSpec.describe Cryptoexchange::Client do
  let(:client) { Cryptoexchange::Client.new }

  it 'throws Cryptoexchange::HttpConnectionError' do
    expect(StringHelper).to receive(:camelize) { "Gdax" }
    expect_any_instance_of(Cryptoexchange::Exchanges::Gdax::Services::Pairs).to receive(:fetch) { raise HTTP::ConnectionError }
    expect{ client.pairs('gdax') }.to raise_error(Cryptoexchange::HttpConnectionError)
  end

  it 'throws Cryptoexchange::HttpTimeoutError' do
    expect(StringHelper).to receive(:camelize) { "Gdax" }
    expect_any_instance_of(Cryptoexchange::Exchanges::Gdax::Services::Pairs).to receive(:fetch) { raise HTTP::TimeoutError }
    expect{ client.pairs('gdax') }.to raise_error(Cryptoexchange::HttpTimeoutError)
  end

  it 'throws Cryptoexchange::JsonParseError' do
    expect(StringHelper).to receive(:camelize) { "Gdax" }
    expect_any_instance_of(Cryptoexchange::Exchanges::Gdax::Services::Pairs).to receive(:fetch) { raise JSON::ParserError }
    expect{ client.pairs('gdax') }.to raise_error(Cryptoexchange::JsonParseError)
  end

  it 'throws Cryptoexchange::TypeFormatError' do
    expect(StringHelper).to receive(:camelize) { "Gdax" }
    expect_any_instance_of(Cryptoexchange::Exchanges::Gdax::Services::Pairs).to receive(:fetch) { raise TypeError }
    expect{ client.pairs('gdax') }.to raise_error(Cryptoexchange::TypeFormatError)
  end

end
