require 'spec_helper'

describe Jellyfish::Provisioner do
  before(:each) { class_double("OrderItem", find: order_item).as_stubbed_const }

  it 'finds an order item and initailizes with it, then saves the record' do
    allow(order_item).to receive(:save!)

    provisioner.provision(1)

    expect(OrderItem).to have_received(:find)
    expect(order_item).to have_received(:save!)
  end

  describe '.provision' do
    it 'delegates to instance' do
      expect(provisioner.provision(1)).to eq 'provisioned'
    end

    it 'notes a critical status and stores a message' do
      allow_any_instance_of(provisioner).to receive(:provision).and_raise('strong bad')

      expect { provisioner.provision(1) }.to raise_error

      expect(order_item.provision_status).to eq :critical
      expect(order_item.status_msg).to eq('strong bad')
    end
  end

  describe '.retire' do
    it 'delegates to instance' do
      expect(provisioner.retire(1)).to eq 'retired'
    end

    it 'notes a warning status and stores an error' do
      allow_any_instance_of(provisioner).to receive(:retire).and_raise('weak bad')

      expect { provisioner.retire(1) }.to raise_error

      expect(order_item.provision_status).to eq :warning
      expect(order_item.status_msg).to eq('Retirement failed: weak bad')
    end
  end

  def provisioner
    @provisioner ||= Class.new(Jellyfish::Provisioner) do
      def provision
        'provisioned'
      end

      def retire
        'retired'
      end
    end
  end

  def order_item
    @order_item ||= Class.new do
      attr_accessor :provision_status, :status_msg

      def save!
        'saved'
      end
    end.new
  end
end
