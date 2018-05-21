require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cpdax::Market do
  it { expect(described_class::NAME).to eq 'cpdax' }
  it { expect(described_class::API_URL).to eq 'https://api.cpdax.com/api/v1' }
end
