require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Whitebit::Market do
  it { expect(described_class::NAME).to eq 'whitebit' }
  it { expect(described_class::API_URL).to eq 'https://whitebit.com/api/v2' }
end
