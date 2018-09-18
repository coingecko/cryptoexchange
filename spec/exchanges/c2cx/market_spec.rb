require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::C2cx::Market do
  it { expect(Cryptoexchange::Exchanges::C2cx::Market::NAME).to eq 'C2CX' }
  it { expect(Cryptoexchange::Exchanges::C2cx::Market::API_URL).to eq 'https://api.c2cx.com/v1' }
end
