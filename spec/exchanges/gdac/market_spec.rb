require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Gdac::Market do
  it { expect(described_class::NAME).to eq 'gdac' }
  it { expect(described_class::API_URL).to eq 'https://marketapi.gdac.co.kr/v1' }
end
