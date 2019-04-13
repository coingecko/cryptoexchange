require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Purcow::Market do
  it { expect(described_class::NAME).to eq 'purcow' }
  it { expect(described_class::API_URL).to eq 'https://www.purcow.io/api/v1' }
end
