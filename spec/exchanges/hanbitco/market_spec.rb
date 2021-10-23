require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Hanbitco::Market do
  it { expect(described_class::NAME).to eq 'hanbitco' }
  it { expect(described_class::API_URL).to eq 'https://user-api.hanbitco.com/v1' }
end
