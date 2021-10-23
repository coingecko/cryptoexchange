require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Hoo::Market do
  it { expect(described_class::NAME).to eq 'hoo' }
  it { expect(described_class::API_URL).to eq 'https://api.hoo.com/open/v1' }
end
