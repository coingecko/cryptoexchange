require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tokpie::Market do
  it { expect(described_class::NAME).to eq 'tokpie' }
  it { expect(described_class::API_URL).to eq 'https://tokpie.com' }
end
