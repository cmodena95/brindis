# frozen_string_literal: true

require "browser/aliases"

module DetectDevice
  extend ActiveSupport::Concern

  Browser::Base.include(Browser::Aliases)

  included do
    before_action :set_variant
  end

  def set_variant
    browser = Browser.new(request.user_agent)
    if browser.mobile?
      request.variant = :phone
    elsif browser.tablet?
      request.variant = :tablet
    end
  end
end
