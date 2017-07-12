require 'spec_helper'

RSpec.describe Cryptoexchange::Services::Pairs do
  let(:pairs) { Cryptoexchange::Services::Pairs.new }

  it 'fetches with API if PAIRS_URL exists' do
    stub_const("Cryptoexchange::Services::Pairs::PAIRS_URL", "https://www.example.com")
    allow(HTTP).to receive(:get)
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

end
