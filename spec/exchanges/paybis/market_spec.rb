require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Paybis::Market do
  it { expect(described_class::NAME).to eq 'paybis' }
  it { expect(described_class::API_URL).to eq 'https://paybis.com' }
end
