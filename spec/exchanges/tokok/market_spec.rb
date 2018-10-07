require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tokok::Market do
  it { expect(described_class::NAME).to eq 'tokok' }
  it { expect(described_class::API_URL).to eq 'https://www.tokok.com/api/v1' }
end
