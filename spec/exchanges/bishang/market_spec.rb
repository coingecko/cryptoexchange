require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bishang::Market do
  it { expect(described_class::NAME).to eq 'bishang' }
  it { expect(described_class::API_URL).to eq 'https://www.bishang.pro:91/api/v1' }
end
