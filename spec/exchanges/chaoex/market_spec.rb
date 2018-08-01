require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Chaoex::Market do
  it { expect(described_class::NAME).to eq 'chaoex' }
  it { expect(described_class::API_URL).to eq 'https://www.chaoex.com/12lian' }
end
