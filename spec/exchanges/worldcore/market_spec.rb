require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Worldcore::Market do
  it { expect(described_class::NAME).to eq 'worldcore' }
  it { expect(described_class::API_URL).to eq 'https://api.worldcore.trade' }
end
