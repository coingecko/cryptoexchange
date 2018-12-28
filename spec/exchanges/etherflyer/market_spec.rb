require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Etherflyer::Market do
  it { expect(described_class::NAME).to eq 'etherflyer' }
  it { expect(described_class::API_URL).to eq 'https://open.etherflyer.com' }
end
