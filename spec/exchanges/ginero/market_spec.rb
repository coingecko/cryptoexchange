require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ginero::Market do
  it { expect(described_class::NAME).to eq 'ginero' }
  it { expect(described_class::API_URL).to eq 'https://ginero.io/api' }
end
