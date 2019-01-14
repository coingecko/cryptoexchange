require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Fourteenbit::Market do
  it { expect(Cryptoexchange::Exchanges::Fourteenbit::Market::NAME).to eq 'fourteenbit' }
  it { expect(Cryptoexchange::Exchanges::Fourteenbit::Market::API_URL).to eq 'https://14bit.com/api' }
end
