class PagesController < ApplicationController
  PIN_FORMAT = /\A\d{4,6}\z/

  def home
  end

  def scanner
  end

  # The scanned QR content is kept in the browser's sessionStorage and shown
  # on this page with textContent, so it is never interpreted as HTML.
  def confirmation
  end

  def pin
  end

  # Demo only: checks the PIN format, never stores or logs the PIN
  # (see config/initializers/filter_parameter_logging.rb).
  def summary
    @pin_valid = params[:pin].to_s.match?(PIN_FORMAT)
    if !@pin_valid
      render :summary, status: :unprocessable_entity
    end
  end
end
