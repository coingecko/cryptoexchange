require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bcex::Market do
  it { expect(described_class::NAME).to eq 'bcex' }
  it { expect(described_class::API_URL).to eq 'https://www.bcex.ca/api' }
end
