require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Uex::Market do
  it { expect(described_class::NAME).to eq 'uex' }
  it { expect(described_class::API_URL).to eq 'https://open-api.uex.com' }
end
