class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  def after_users_sign_up_path_for(resource)
    users_profile_path #サインイン後に遷移するpathを設定
  end

  def after_sign_in_path_for(resource)
    root_path # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end
end
