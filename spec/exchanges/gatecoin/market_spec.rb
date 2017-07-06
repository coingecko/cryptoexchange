require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Gatecoin::Market do
  it { expect(Cryptoexchange::Exchanges::Gatecoin::Market::NAME).to eq 'gatecoin' }
  it { expect(Cryptoexchange::Exchanges::Gatecoin::Market::API_URL).to eq 'https://api.gatecoin.com' }
end
