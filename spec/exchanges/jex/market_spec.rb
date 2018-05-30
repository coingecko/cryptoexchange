require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Jex::Market do
  it { expect(described_class::NAME).to eq 'jex' }
  it { expect(described_class::API_URL).to eq 'https://www.jex.com/api/v2/pub/jexcap' }
end
