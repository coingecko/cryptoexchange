require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Indodax::Market do
  it { expect(described_class::NAME).to eq 'indodax' }
  it { expect(described_class::API_URL).to eq 'https://indodax.com/api' }
end
