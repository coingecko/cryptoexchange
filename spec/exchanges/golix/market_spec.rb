require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Golix::Market do
  it { expect(described_class::NAME).to eq 'golix' }
  it { expect(described_class::API_URL).to eq 'https://golix.com/api/v1' }
end
