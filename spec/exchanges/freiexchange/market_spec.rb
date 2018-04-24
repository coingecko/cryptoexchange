require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Freiexchange::Market do
  it { expect(described_class::NAME).to eq 'freiexchange' }
  it { expect(described_class::API_URL).to eq 'https://freiexchange.com/api' }
end
