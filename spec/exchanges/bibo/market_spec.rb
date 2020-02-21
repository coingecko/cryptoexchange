require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bibo::Market do
  it { expect(described_class::NAME).to eq 'bibo' }
  it { expect(described_class::API_URL).to eq 'https://www.bibo.gold' }
end
