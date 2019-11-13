require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Basefex::Market do
  it { expect(described_class::NAME).to eq 'basefex' }
  it { expect(described_class::API_URL).to eq 'https://api.basefex.com' }
end
