require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Dsx::Market do
  it { expect(described_class::NAME).to eq 'dsx' }
  it { expect(described_class::API_URL).to eq 'https://dsx.uk/mapi' }
end
