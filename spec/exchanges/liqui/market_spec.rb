require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Liqui::Market do
  it { expect(Cryptoexchange::Exchanges::Liqui::Market::NAME).to eq 'liqui' }
  it { expect(Cryptoexchange::Exchanges::Liqui::Market::API_URL).to eq 'https://api.liqui.io/api/3' }
end
