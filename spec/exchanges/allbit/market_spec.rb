require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Allbit::Market do
  it { expect(described_class::NAME).to eq 'allbit' }
  it { expect(described_class::API_URL).to eq 'https://allbit.com/api' }
end
