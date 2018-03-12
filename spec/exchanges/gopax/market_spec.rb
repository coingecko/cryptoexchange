require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Gopax::Market do
  it { expect(described_class::NAME).to eq 'gopax' }
  it { expect(described_class::API_URL).to eq 'https://api.gopax.co.kr/' }
end
