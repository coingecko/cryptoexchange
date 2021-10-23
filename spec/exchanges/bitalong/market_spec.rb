require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitalong::Market do
  it { expect(described_class::NAME).to eq 'bitalong' }
  it { expect(described_class::API_URL).to eq 'https://www.bitalong.com/api' }
end
