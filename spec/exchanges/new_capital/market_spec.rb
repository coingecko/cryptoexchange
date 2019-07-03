require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::NewCapital::Market do
  it { expect(described_class::NAME).to eq 'new_capital' }
  it { expect(described_class::API_URL).to eq 'https://api.new.capital/v1' }
end
