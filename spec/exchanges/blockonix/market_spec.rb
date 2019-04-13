require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Blockonix::Market do
  it { expect(described_class::NAME).to eq 'blockonix' }
  it { expect(described_class::API_URL).to eq 'https://dexserver.blockonix.com' }
end
