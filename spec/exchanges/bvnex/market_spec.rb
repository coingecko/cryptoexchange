require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bvnex::Market do
  it { expect(described_class::NAME).to eq 'bvnex' }
  it { expect(described_class::API_URL).to eq 'https://api.bvnex.com/api' }
end
