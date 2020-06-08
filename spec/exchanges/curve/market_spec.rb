require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Curve::Market do
  it { expect(described_class::NAME).to eq 'curve' }
end
