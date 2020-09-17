class UsersController < ApplicationController

    def create
        user = User.create(user_params)
        if user.valid?
            token = JWT.encode({ user_id: user.id }, 'so_secret', 'HS256')

            render json: { user: UserSerializer.new(user), token: token }, status: :created
        else 
            render json: { error: user.errors.full_messages }, status: :bad_request
        end
    end

    def login
        user = User.find_by(username: user_params[:username])
        if user && user.authenticate(user_params[:password])
            token = JWT.encode({ user_id: user.id }, 'so_secret', 'HS256')
            
            render json: { user: UserSerializer.new(user), token: token }, status: :authorized
        else
            render json: { error: 'Invalid username or password' }, status: :unauthorized
        end
    end

    def autologin
        auth_header = request.headers['Authorization']
        token = auth_header.split(' ')[1]

        decoded_token = JWT.decode(token, "so_secret", true, {algorithm: 'HS256'})

        user_id = decoded_token[0]["user_id"]
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
