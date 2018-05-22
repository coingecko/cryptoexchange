require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinsuper::Market do
  it { expect(described_class::NAME).to eq 'coinsuper' }
  it { expect(described_class::API_URL).to eq 'https://www.coinsuper.com/v1/api' }
end
