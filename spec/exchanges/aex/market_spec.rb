require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Aex::Market do
  it { expect(described_class::NAME).to eq 'aex' }
  it { expect(described_class::API_URL).to eq 'https://api.aex.zone' }
end
