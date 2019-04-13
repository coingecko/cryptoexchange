require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Catex::Market do
  it { expect(Cryptoexchange::Exchanges::Catex::Market::NAME).to eq 'catex' }
  it { expect(Cryptoexchange::Exchanges::Catex::Market::API_URL).to eq 'https://www.catex.io/api' }
end
