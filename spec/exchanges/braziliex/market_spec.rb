require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Braziliex::Market do
  it { expect(described_class::NAME).to eq 'braziliex' }
  it { expect(described_class::API_URL).to eq 'https://braziliex.com/api/v1/public' }
end
