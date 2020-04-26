require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ionomy::Market do
  it { expect(described_class::NAME).to eq 'ionomy' }
  it { expect(described_class::API_URL).to eq 'https://ionomy.com/api/v1' }
end
