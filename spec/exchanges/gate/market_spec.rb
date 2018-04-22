require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Gate::Market do
  it { expect(described_class::API_URL).to eq 'http://data.gate.io/api/1' }
end
