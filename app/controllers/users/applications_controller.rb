class User::ApplicationsController < ApplicationController
    before_action :authenticate_user!

    def index
        @jobs = current_user.jobs
    end

end