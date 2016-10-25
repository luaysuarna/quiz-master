class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  	def success_api(hash = {}, message = nil, status = :created)
	    _respond = { success: true, status: status, message: message }
	    _respond = _respond.merge(hash)

	    return _respond
	  end

	  def failed_api(hash = {}, message = nil, status = :unprocessable_entity)
	    _respond = { success: false, status: status, message: message }
	    _respond = _respond.merge(hash)

	    return _respond
	  end
end
