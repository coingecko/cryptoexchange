require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Biztranex::Market do
  it { expect(described_class::NAME).to eq 'biztranex' }
  it { expect(described_class::API_URL).to eq 'https://biztranex.com/api-v1/public' }
end
