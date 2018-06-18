require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Fcoin::Market do
  it { expect(described_class::NAME).to eq 'fcoin' }
  it { expect(described_class::API_URL).to eq 'https://api.fcoin.com/v2' }
end
