module Admin::UsersHelper
    def choose_new_or_edit
        if action_name == 'new' || action_name == 'create'
               admin_users_path
        elsif action_name == 'edit' || action_name == 'update'
               admin_user_path
        end
    end

end
