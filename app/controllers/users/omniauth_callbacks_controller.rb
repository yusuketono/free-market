class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    email = request.env["omniauth.auth"].info.email
    nickname = request.env["omniauth.auth"].info.name
    ## ーーーーー追加ここからーーーーー
    uid = request.env["omniauth.auth"].uid
    provider = request.env["omniauth.auth"].provider  
    
    SnsCredential.create(uid: uid, provider: provider)
    ## ーーーーー追加ここまでーーーーー

    @user = User.new(email: email, nickname: nickname)
    render layout: 'no_menu', template: 'devise/registrations/new'
  end

  def failure
    redirect_to root_path, alert: "エラーが発生しました" and return
  end
end