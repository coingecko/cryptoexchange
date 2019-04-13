require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Incorex::Market do
  it { expect(described_class::NAME).to eq 'incorex' }
  it { expect(described_class::API_URL).to eq 'https://api.incorex.com/v1' }
end
