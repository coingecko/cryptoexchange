require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Idax::Market do
  it { expect(described_class::NAME).to eq 'idax' }
  it { expect(described_class::API_URL).to eq 'https://www.idax.mn/api/Signalr' }
end
