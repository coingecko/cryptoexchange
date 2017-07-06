require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cryptopia::Market do
  it { expect(Cryptoexchange::Exchanges::Cryptopia::Market::NAME).to eq 'cryptopia' }
  it { expect(Cryptoexchange::Exchanges::Cryptopia::Market::API_URL).to eq 'https://www.cryptopia.co.nz/api' }
end
