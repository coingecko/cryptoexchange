require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Piexgo::Market do
  it { expect(described_class::NAME).to eq 'piexgo' }
  it { expect(described_class::API_URL).to eq 'https://api.piexgo.com' }
end
