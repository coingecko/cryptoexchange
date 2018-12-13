require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Novadax::Market do
  it { expect(described_class::NAME).to eq 'novadax' }
  it { expect(described_class::API_URL).to eq 'https://api.novadax.com/v1' }
end
