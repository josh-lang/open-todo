module Api
  class Api::ItemsController < Api::ApiController
    before_action :auth_and_set_user
    before_action :set_item, except: :create
    before_action :set_list, except: :destroy

    def create
      if @list.present?
        if @list.permissions == 'open' || @user == @list.user
          if @list.add(params[:item][:description])
            render json: @item, status: :created
          else
            render json: @item.errors, status: :unprocessable_entity
          end
        else
          error(403, 'You are not authorized to add items to this list')
        end
      else
        error(404, 'No list found with that id')
      end
    end

    def destroy
      if @item.present?
        @item.mark_complete
        head :no_content
      else
        error(404, 'No item found with that id')
      end
    end

    private

    def set_item
      @item = Item.find_by(id: params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def item_params
      params.require(:item).permit(:description)
    end
  end
end
