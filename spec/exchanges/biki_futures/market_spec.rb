require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BikiFutures::Market do
  it { expect(described_class::NAME).to eq 'biki_futures' }
  it { expect(described_class::API_URL).to eq 'https://coapi.biki51.com/swap' }
end
