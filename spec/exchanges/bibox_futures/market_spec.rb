require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BiboxFutures::Market do
  it { expect(described_class::NAME).to eq 'bibox_futures' }
  it { expect(described_class::API_URL).to eq 'https://api.bibox.com/v1' }
end
