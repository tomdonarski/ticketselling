# frozen_string_literal: true

RSpec.describe TicketPayment do
  describe ".call" do
    # subject { described_class.call(ticket, token, tickets_count) }
    subject { described_class.call(reservation, token) }

    let(:reservation) { create(:reservation) }
    let(:event) { create(:event) }
    let(:token) { "token" }


    # context "when tickets are available" do
    #   let(:tickets_count) { 1 }
    #
    #   it "should call payment adapter" do
    #     expect(Payment::Gateway).to receive(:charge).with(amount: ticket.price, token: token)
    #     subject
    #   end
    #
    #   it "should update available tickets count" do
    #     expect { subject }.to change(ticket, :available).by(-1)
    #   end
    # end

    # context "when tickets are not available" do
    #   let(:tickets_count) { ticket.available + 1 }
    #
    #   it "should raise error" do
    #     expect { subject }.to raise_error(TicketPayment::NotEnoughTicketsError)
    #   end
    # end

    context "when reservation is paid" do
      let(:reservation) { create(:reservation, :paid) }

      it "should raise error" do
        expect { subject }.to raise_error(TicketPayment::ReservationPaid)
      end
    end

    context "when reservation has expired" do
      let(:reservation) { create(:reservation, :expired) }

      it "should raise error" do
        expect { subject }.to raise_error(TicketPayment::ReservationExpired)
      end
    end

    # context "when reservation is neither paid nor expired" do
    #   let(:ticket) { create(:ticket, event: event, available: 5, reserved: 3, sold: 0) }
    #
    #   it "should call payment adapter" do
    #     expect(Payment::Gateway).to receive(:charge).with(amount: ticket.price, token: token)
    #     subject
    #   end
    #
    #   it "should update ticket and reservation" do
    #     expect { subject }.to change { ticket.reload.reserved }.from(3).to(2)
    #       .and change { ticket.reload.sold }.from(0).to(1)
    #   end
    # end
  end
end
