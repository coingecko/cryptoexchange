require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Thinkbit::Market do
  it { expect(described_class::NAME).to eq 'thinkbit' }
  it { expect(described_class::API_URL).to eq 'https://api.thinkbit.com/v2' }
end
