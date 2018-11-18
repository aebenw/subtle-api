module Api
  module V1

    class UsersController < ApplicationController

      def index
        @users = User.all
        render json: @users
      end

      def show
        user = User.find(params[:id])
        render json: user
      end

      def update
        user = User.find(user_params[:id])
        user.update(name: user_params[:name], description: user_params[:description])

        if user_params[:profile]
          blob = ActiveStorage::Blob.find_by(filename: user_params[:profile])
          user.profile.attach(blob)
        end
        user.save
        render json: user
      end

      def edit
        byebug


      end


      def create
        user = User.new(user_params)
        if user.save
          serialized_data = ActiveModelSerializers::Adapter::Json.new(
            UserSerializer.new(user)
          ).serializable_hash
          token = encode({jwt: user.id})
          render json: {jwt: token, user: serialized_data}
        else
          render json: {error: "account already exists"}
        end
      end

      def content

        # num = [0,1,2].sample
        # content = []
        # type = ''
        # if num == 0
        #   10.times do
        #      content << UserSerializer.new(User.all.sample)
        #    end
        #   type = 'users'
        # elsif num == 1
        #   10.times do
        #     content << ChannelSerializer.new(Channel.all.sample)
        #   end
        #   type = 'channels'
        # elsif num == 2
        #    10.times do
        #      content << BlockSerializer.new(Block.all.sample)
        #    end
        #   type = 'blocks'
        # end
        Block.first
        block = [Block.first, Block.find(2)]
        content = block.map{|x| BlockSerializer.new(x) }
        type = "block"

        render json: {content: content, type: type}

      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :name, :profile, :description, :id)
      end


    end
  end
end
