require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cashierest::Market do
  it { expect(Cryptoexchange::Exchanges::Cashierest::Market::NAME).to eq 'cashierest' }
  it { expect(Cryptoexchange::Exchanges::Cashierest::Market::API_URL).to eq 'https://rest.cashierest.com/Public' }
end
