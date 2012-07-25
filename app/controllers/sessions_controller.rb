class SessionsController < ApplicationController
  def callback
    raise request.env['omniauth.auth'].to_yaml
  end
end
