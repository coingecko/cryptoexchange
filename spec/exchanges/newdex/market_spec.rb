require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Newdex::Market do
  it { expect(described_class::NAME).to eq 'newdex' }
  it { expect(described_class::API_URL).to eq 'https://api.newdex.io' }
end
