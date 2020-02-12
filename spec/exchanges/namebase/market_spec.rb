require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Namebase::Market do
  it { expect(described_class::NAME).to eq 'namebase' }
  it { expect(described_class::API_URL).to eq 'https://www.namebase.io/api/v0' }
end
