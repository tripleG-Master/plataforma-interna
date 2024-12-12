class Admin::ApplicationsController < ApplicationController
    before_action :authenticate_admin
    before_action :set_application, only: %i[destroy]

    def index
        # Inicializa la colección de aplicaciones
        @applications = Application.all

        # Filtra por user_id si se proporciona
        @applications = @applications.where(user_id: params[:user_id]) if params[:user_id].present?
            
        # Filtra por estado si se proporciona
        @applications = @applications.where(status_new: true) if params[:filter] == 'new'
            
        # Ordena las aplicaciones por fecha de creación
        @applications = @applications.order(:created_at)

        # Para depuración, puedes imprimir las aplicaciones
        Rails.logger.info "\n\n\n applies: #{@applications.pluck(:id)} \n\n\n"
    end

    def destroy
        @joboffer = @application.joboffer
        @application.destroy
        redirect_to admin_joboffer_path(@joboffer), notice: 'Application deleted successfully.'
    end
    
    def update_status
        @application = Application.find(params[:id])
        @application.update(status_new: false)    
        respond_to do |format|
            format.json { render json: { success: true, message: 'Status updated successfully' } }
        end
    end

    private

    def set_application 
        @application = Application.find(params[:id])
    end

end