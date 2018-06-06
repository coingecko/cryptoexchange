require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cybex::Market do
  it { expect(described_class::NAME).to eq 'cybex' }
  it { expect(described_class::API_URL).to eq 'https://beijing.51nebula.com' }
end
