require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cointeb::Market do
  it { expect(described_class::NAME).to eq 'cointeb' }
  it { expect(described_class::API_URL).to eq 'https://www.cointeb.com/v1/api' }
end
