require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Yunbi::Market do
  it { expect(described_class::NAME).to eq 'yunbi' }
  it { expect(described_class::API_URL).to eq 'https://yunbi.com/api/v2' }
end
