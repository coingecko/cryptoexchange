require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Gate::Services::Pairs do
  it { expect(described_class::PAIRS_URL).to eq 'http://data.gate.io/api2/1/pairs' }
end
