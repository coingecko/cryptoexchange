require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Escodex::Market do
  it { expect(described_class::NAME).to eq 'escodex' }
  it { expect(described_class::API_URL).to eq 'http://labs.escodex.com/api' }
end
