require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Instantbitex::Market do
  it { expect(described_class::NAME).to eq 'instantbitex' }
  it { expect(described_class::API_URL).to eq 'https://api.instantbitex.com' }
end
