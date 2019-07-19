require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Xfutures::Market do
  it { expect(described_class::NAME).to eq 'xfutures' }
  it { expect(described_class::API_URL).to eq 'https://www.xfutures.io/api' }
end
