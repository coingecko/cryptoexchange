require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ccex::Market do
  it { expect(Cryptoexchange::Exchanges::Ccex::Market::NAME).to eq 'ccex' }
  it { expect(Cryptoexchange::Exchanges::Ccex::Market::API_URL).to eq 'https://c-cex.com/t' }
end
