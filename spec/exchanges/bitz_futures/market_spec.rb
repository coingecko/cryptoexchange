require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitzFutures::Market do
  it { expect(described_class::NAME).to eq 'bitz_futures' }
  it { expect(described_class::API_URL).to eq "https://apiv2.bitz.com" }
end
