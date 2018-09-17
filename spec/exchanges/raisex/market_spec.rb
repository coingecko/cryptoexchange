require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Raisex::Market do
  it { expect(described_class::NAME).to eq 'raisex' }
  it { expect(described_class::API_URL).to eq 'https://raisex.io/api' }
end
