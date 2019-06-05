class ApplicationController < ActionController::API

    def current_user
        jwt_token = request.headers['JWT-Auth-Key']
        if !jwt_token
            return nil
        end
        key = JWT.decode(jwt_token, ENV['JWT_AUTH_KEY']).first
        User.find_by(id: key["user_id"])
    end

    def authorize!
        unless current_user
            render json: { errors: "You need to be logged in to do that action." }, status: :unauthorized
        end
    end

end
