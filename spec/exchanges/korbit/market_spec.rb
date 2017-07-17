require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Korbit::Market do
  it { expect(described_class::NAME).to eq 'korbit' }
  it { expect(described_class::API_URL).to eq 'https://api.korbit.co.kr/v1' }
end
