require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Artisturba::Market do
  it { expect(described_class::NAME).to eq 'artisturba' }
  it { expect(described_class::API_URL).to eq 'https://www.artisturba.com/api' }
end
