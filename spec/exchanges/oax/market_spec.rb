require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Oax::Market do
  it { expect(described_class::NAME).to eq 'oax' }
  it { expect(described_class::API_URL).to eq 'https://www.oax.com/api' }
end
