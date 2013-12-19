class HomeController < ApplicationController
    def index
        unless user_signed_in?
            redirect_to new_user_session_path
        else
        @post = Post.new
        friends_ids = current_user.followees(User).pluck(:id)
	friends_ids << current_user.id # Allow the user to see himself on the newsfeed
        
        @activities = PublicActivity::Activity.where(owner_id: friends_ids, owner_type: "User")
        end
    end

end
