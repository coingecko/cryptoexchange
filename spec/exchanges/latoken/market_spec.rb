require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Latoken::Market do
  it { expect(described_class::NAME).to eq 'latoken' }
  it { expect(described_class::API_URL).to eq 'https://api.latoken.com/api/v1' }
end
