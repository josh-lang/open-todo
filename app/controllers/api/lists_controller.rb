module Api
  class Api::ListsController < Api::ApiController
    before_action :auth_and_set_user
    before_action :set_list, only: [:show, :update, :destroy]

    def index
      @lists = List.all.select {|l| l if @user.can?(:view, l)}
      unless @lists.empty?
        render json: @lists, each_serializer: ListSerializer
      else
        error(404, 'Go make some lists or friends that share lists; you apparently have neither...')
      end
    end

    def show
      if @list.present?
        if @user.can?(:view, @list)
          render json: @list
        else
          error(403, 'You are not authorized to view this list')
        end
      else
        error(404, 'No list found with that id')
      end
    end

    def create
      @list = List.new(list_params)
      @list.user = @user
      if @list.save
        render json: @list, status: :created
      else
        render json: @list.errors, status: :unprocessable_entity
      end
    end

    def update
      if @list.present?
        if @user == @list.user
          if @list.update(list_params)
            render json: @list, status: :ok
          else
            render json: @list.errors, status: :unprocessable_entity
          end
        else
          error(403, "You are not authorized to edit this list's name or permissions")
        end
      else
        error(404, 'No list found with that id')
      end
    end

    def destroy
      if @list.present?
        if @user == @list.user
          @list.destroy
          head :no_content
        else
          error(403, "You are not authorized to delete this list")
        end
      else
        error(404, 'No list found with that id')
      end
    end

    private

    def set_list
      @list = List.find_by(id: params[:id])
    end

    def list_params
      params.require(:list).permit(:name, :permissions)
    end
  end
end
