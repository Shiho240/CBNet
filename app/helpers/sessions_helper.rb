module SessionsHelper

	def log_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		self.current_user = user
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		@current_user ||= user_from_remember_token
	end
	
	def authenticator
	redirect_to login_path, :notice =>"UNAUTHORIZED ACCESS DETECTED, Please sign in to continue!" unless signed_in?
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	def log_out
	cookies.delete(:remember_token)
		self.current_user = nil
	end
	def current_user?(user)
		@user == current_user
	end
	private
	
	def user_from_remember_token
		User.authenticate_with_salt(*remember_token)
	end
	
	def remember_token
		cookies.signed[:remember_token] || [nil,nil]
	end
end
