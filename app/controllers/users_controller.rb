class UsersController < ApplicationController

    def create
        user = User.create(user_params)
        if user.valid?
            render json: { user: UserSerializer.new(user) }, status: :created
        else 
            render json: { error: 'unable to create account' }, status: :bad_request
        end
    end

    def login
        user = User.find_by(username: user_params[:username])
        if user && user.authenticate(user_params[:password])
            render json: { user: UserSerializer.new(user) }, status: :authorized
        else
            render json: { error: 'Invalid username or password' }, status: :unauthorized
        end
    end

    def autologin
        user = User.find_by()

        if user
            render json: { user: UserSerializer.new(user) }, status: :authorized
        else
            render json: { error: 'Not logged in' }, status: :unauthorized
        end
        
    end

    private
    
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

end
