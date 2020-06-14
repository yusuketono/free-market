class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)  
    email = request.env["omniauth.auth"].info.email
    nickname = request.env["omniauth.auth"].info.name
    uid = request.env["omniauth.auth"].uid
    provider = request.env["omniauth.auth"].provider  
    
    SnsCredential.create(uid: uid, provider: provider)
    @user = User.new(email: email, nickname: nickname)
    render layout: 'no_menu', template: 'devise/registrations/new'
  end
end