require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Fmex::Market do
  it { expect(described_class::NAME).to eq 'fmex' }
  it { expect(described_class::API_URL).to eq 'https://api.fmex.com/v2' }
end
