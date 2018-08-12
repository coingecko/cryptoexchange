require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cxihub::Market do
  it { expect(described_class::NAME).to eq 'cxihub' }
  it { expect(described_class::API_URL).to eq 'https://api.cxihub.com' }
end
