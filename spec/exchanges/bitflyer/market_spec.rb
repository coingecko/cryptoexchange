require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitflyer::Market do
  it { expect(Cryptoexchange::Exchanges::Bitflyer::Market::NAME).to eq 'bitflyer' }
  it { expect(Cryptoexchange::Exchanges::Bitflyer::Market::API_URL).to eq 'https://api.bitflyer.jp/v1/' }
end
