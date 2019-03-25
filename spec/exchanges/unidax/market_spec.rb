require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Unidax::Market do
  it { expect(described_class::NAME).to eq 'unidax' }
  it { expect(described_class::API_URL).to eq 'https://api.unidax.com/open/api' }
end
