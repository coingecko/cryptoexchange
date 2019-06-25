require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Biki::Market do
  it { expect(described_class::NAME).to eq 'biki' }
  it { expect(described_class::API_URL).to eq 'https://api.biki.com/open/api' }
end