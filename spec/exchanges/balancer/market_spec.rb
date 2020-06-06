require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Balancer::Market do
  it { expect(described_class::NAME).to eq 'balancer' }
end
