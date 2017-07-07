require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Korbit::Market do
  it { expect(Cryptoexchange::Exchanges::Korbit::Market::NAME).to eq 'korbit' }
  it { expect(Cryptoexchange::Exchanges::Korbit::Market::API_URL).to eq 'https://api.korbit.co.kr/v1' }
end
