require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Btcexa::Market do
  it { expect(described_class::NAME).to eq 'btcexa' }
  it { expect(described_class::API_URL).to eq 'https://api.btcexa.com/api' }
end
