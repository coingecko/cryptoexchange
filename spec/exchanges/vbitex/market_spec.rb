require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Vbitex::Market do
  it { expect(described_class::NAME).to eq 'vbitex' }
  it { expect(described_class::API_URL).to eq 'http://www.vbitex.com' }
end
