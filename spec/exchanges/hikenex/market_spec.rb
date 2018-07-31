require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Hikenex::Market do
  it { expect(described_class::NAME).to eq 'hikenex' }
  it { expect(described_class::API_URL).to eq 'https://hikenex.com/remote/v1' }
end
