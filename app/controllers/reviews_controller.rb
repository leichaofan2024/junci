class ReviewsController < ApplicationController

  def create
    if current_user
      @product = Product.find(params[:product_id])
      @review = Review.new(review_params)
      @review.user = current_user
      @review.product = @product
      if @review.save
        if params[:pictures] != nil
          params[:pictures]["avatar"].each do |a|
            @picture = @review.pictures.create(:avatar => a)
          end
        end
      end
    else
      flash[:alert] = "亲，请先登录哦！"
    end 
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @review.pictures.destroy_all
    @review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
