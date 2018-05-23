require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Oasisdex::Market do
  it { expect(described_class::NAME).to eq 'oasisdex' }
  it { expect(described_class::API_URL).to eq 'http://api.oasisdex.com/v1' }
end
