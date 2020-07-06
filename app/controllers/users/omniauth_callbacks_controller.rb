class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    user_sns = User.from_omniauth(request.env["omniauth.auth"])
    @user = user_sns[:user]
    sns_credential = user_sns[:sns_credential]

    if @user.persisted?
      ## @userが登録済み
      sns_credential.update(user_id: @user.id)
      sign_in_and_redirect @user, event: :authentication
    else
      ## @userが未登録
      render layout: 'no_menu', template: 'devise/registrations/new'
    end
  end

  def failure
    redirect_to root_path, alert: "エラーが発生しました" and return
  end
end