require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Fubt::Market do
  it { expect(described_class::NAME).to eq 'fubt' }
  it { expect(described_class::API_URL).to eq 'https://api.fubt.co/v1' }
end
