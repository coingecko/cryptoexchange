require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Dragonex::Market do
  it { expect(described_class::NAME).to eq 'dragonex' }
  it { expect(described_class::API_URL).to eq 'https://openapi.dragonex.io' }
end
