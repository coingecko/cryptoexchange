require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Stinex::Market do
  it { expect(described_class::NAME).to eq 'stinex' }
  it { expect(described_class::API_URL).to eq 'https://api.stinex.net/api/v2' }
end
