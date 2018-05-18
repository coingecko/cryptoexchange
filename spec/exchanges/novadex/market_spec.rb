require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Novadex::Market do
  it { expect(described_class::NAME).to eq 'novadex' }
  it { expect(described_class::API_URL).to eq 'https://novadex.io' }
end
