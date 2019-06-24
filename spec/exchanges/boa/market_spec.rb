require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Boa::Market do
  it { expect(described_class::NAME).to eq 'boa' }
  it { expect(described_class::API_URL).to eq 'https://api.boaexchange.com/api/v1/markets' }
end
