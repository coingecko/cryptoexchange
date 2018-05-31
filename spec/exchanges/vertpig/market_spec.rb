require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Vertpig::Market do
  it { expect(described_class::NAME).to eq 'vertpig' }
  it { expect(described_class::API_URL).to eq 'https://www.vertpig.com/api/v1.1' }
end
