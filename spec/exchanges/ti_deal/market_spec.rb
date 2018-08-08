require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TiDeal::Market do
  it { expect(Cryptoexchange::Exchanges::TiDeal::Market::NAME).to eq 'ti_deal' }
  it { expect(Cryptoexchange::Exchanges::TiDeal::Market::API_URL).to eq 'https://tideal.com/api/v2' }
end
