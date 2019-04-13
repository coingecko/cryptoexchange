require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Letsdocoinz::Market do
  it { expect(described_class::NAME).to eq 'letsdocoinz' }
  it { expect(described_class::API_URL).to eq 'http://api.letsdocoinz.com' }
end
