require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bilaxy::Market do
  it { expect(described_class::NAME).to eq 'bilaxy' }
  it { expect(described_class::API_URL).to eq 'http://api.bilaxy.com/v1' }
end
