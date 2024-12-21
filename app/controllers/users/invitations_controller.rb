class Users::InvitationsController < Devise::InvitationsController
    
     before_action :check_user_existence, only: [:create]

     def create
        Rails.logger.debug "Params: #{params.inspect}"
        email = params[:user][:email].to_s
        user = User.find_by(email: invite_params[:email])
      
        if user.present?
          flash[:alert] = "El usuario con el correo #{user.email} ya está registrado."
          redirect_to admin_dashboard_path and return
        else
          # Si el usuario no está registrado, llama al método original para enviar la invitación
          super do |resource|
            flash[:notice] = "Invitación enviada exitosamente."
          end
        end
      end

    
    def resend_invitation
        user = User.find(params[:id])
        if user.invitation_accepted_at.nil?
            user.invite! # Resend the invitation
            flash[:notice] = "Invitación reenviada a #{user.email}."
        else
            flash[:alert] = "El usuario ya ha aceptado la invitación."
        end
        redirect_to users_path # Redirect to the users list or any other page
    end
    
    private
    
    def check_user_existence
        user = User.find_by(email: invite_params[:email])
        
        if user.present? && user.invitation_accepted_at.nil?
            flash[:alert] = "El usuario ya está registrado pero no ha aceptado la invitación."
            redirect_to new_user_invitation_path and return
        elsif user.present?
            flash[:alert] = "El usuario ya está registrado y ha aceptado la invitación."
            redirect_to root_path and return
        end
    end

    private

    def invite_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
