require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Nusax::Market do
  it { expect(described_class::NAME).to eq 'nusax' }
  it { expect(described_class::API_URL).to eq 'https://nusax.co.id/api/v2' }
end
