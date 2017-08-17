require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Jubi::Market do
  it { expect(described_class::NAME).to eq 'jubi' }
  it { expect(described_class::API_URL).to eq 'http://www.jubi.com/api/v1' }
end
