require 'spec_helper'

RSpec.describe Cryptoexchange::Models::ContractStat do
  let(:new_contract_stat) { described_class.new }
  it { expect(new_contract_stat.open_interest).to be_empty }
  it { expect(new_contract_stat.index).to be_empty }
end
