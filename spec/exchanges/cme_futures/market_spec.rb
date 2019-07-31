require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CmeFutures::Market do
  it { expect(described_class::NAME).to eq 'cme_futures' }
  it { expect(described_class::API_URL).to eq 'https://www.cmegroup.com' }
end
