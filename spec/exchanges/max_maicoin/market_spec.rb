require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::MaxMaicoin::Market do
  it { expect(described_class::NAME).to eq 'max_maicoin' }
  it { expect(described_class::API_URL).to eq 'https://max-api.maicoin.com/api/v2' }
end
