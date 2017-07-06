require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coincheck::Market do
  it { expect(Cryptoexchange::Exchanges::Coincheck::Market::NAME).to eq 'coincheck' }
  it { expect(Cryptoexchange::Exchanges::Coincheck::Market::API_URL).to eq 'https://coincheck.com/api/' }
end
