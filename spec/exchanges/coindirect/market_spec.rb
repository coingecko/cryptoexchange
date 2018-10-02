require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coindirect::Market do
  it { expect(described_class::NAME).to eq 'coindirect' }
  it { expect(described_class::API_URL).to eq 'https://api.coindirect.com/api/v1' }
end
