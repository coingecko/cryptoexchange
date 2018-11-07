require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ovis::Market do
  it { expect(described_class::NAME).to eq 'ovis' }
  it { expect(described_class::API_URL).to eq 'https://api.ovis.com.tr/public' }
end
