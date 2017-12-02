require 'spec_helper'

RSpec.describe Cryptoexchange::Models::Order do
  let(:time_now) { Time.now.to_i }
  let(:order) { described_class.new(price: 1000, amount: 9999) }
  let(:order_with_timestamp) do
    described_class.new(price: 1000, amount: 9999, timestamp: time_now)
  end

  it { expect(order.price).to eq 1000 }
  it { expect(order.amount).to eq 9999 }
  it { expect(order.timestamp).to be_nil }
  it { expect(order_with_timestamp.timestamp).to eq time_now }
end
