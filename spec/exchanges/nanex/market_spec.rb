require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Nanex::Market do
  it { expect(described_class::NAME).to eq 'nanex' }
  it { expect(described_class::API_URL).to eq 'https://nanex.co/api' }
end
