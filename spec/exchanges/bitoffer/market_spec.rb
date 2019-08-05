require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitoffer::Market do
  it { expect(described_class::NAME).to eq 'bitoffer' }
  it { expect(described_class::API_URL).to eq 'https://api.bitoffer.com/v1/api' }
end
