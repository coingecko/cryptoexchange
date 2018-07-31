require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TrocaNinja::Market do
  it { expect(described_class::NAME).to eq 'troca_ninja' }
  it { expect(described_class::API_URL).to eq 'https://troca.ninja/api' }
end
