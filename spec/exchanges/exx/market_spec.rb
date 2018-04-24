require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Exx::Market do
  it { expect(described_class::NAME).to eq 'exx' }
  it { expect(described_class::API_URL).to eq 'https://api.exx.com/data/v1' }
end
