require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Koinex::Market do
  it { expect(described_class::NAME).to eq 'koinex' }
  it { expect(described_class::API_URL).to eq 'https://koinex.in/api' }
end
