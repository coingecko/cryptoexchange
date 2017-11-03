require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Exmo::Market do
  it { expect(described_class::NAME).to eq 'exmo' }
  it { expect(described_class::API_URL).to eq 'https://api.exmo.com/v1' }
end
