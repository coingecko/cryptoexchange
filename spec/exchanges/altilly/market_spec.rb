require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Altilly::Market do
  it { expect(described_class::NAME).to eq 'altilly' }
  it { expect(described_class::API_URL).to eq 'https://api.altilly.com/api' }
end
