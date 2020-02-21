require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Deversifi::Market do
  it { expect(described_class::NAME).to eq 'deversifi' }
  it { expect(described_class::API_URL).to eq 'https://api.deversifi.com' }
end
