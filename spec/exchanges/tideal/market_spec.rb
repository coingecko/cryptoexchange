require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tideal::Market do
  it { expect(described_class::NAME).to eq 'tideal' }
  it { expect(described_class::API_URL).to eq 'https://tideal.com/api/v2' }
end
