require "rails_helper"

RSpec.describe ApplicationMailer, :type => :mailer do
  describe "notify" do
    it "can be created" do
        ApplicationMailer.new
    end

  end
end