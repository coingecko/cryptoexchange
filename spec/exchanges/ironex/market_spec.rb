require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ironex::Market do
  it { expect(described_class::NAME).to eq 'ironex' }
  it { expect(described_class::API_URL).to eq 'https://ironex.exchange' }
end
