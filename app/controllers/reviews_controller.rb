class ReviewsController < ApplicationController
    before_action :find_idea
    before_action :authenticated_user!

    def create
        @review = Review.new(params.require(:review).permit(:body))
        @review.idea = @idea
        @review.user = current_user
        if @review.save
            flash[:Notice] = "Reivew Saved!"
            redirect_to idea_path(@idea)
        else
            @reviews = @post.reviews.order(created_at: :asc)
            flash[:Error] = @review.errors.full_messages.to_sentence
            redirect_to idea_path(@idea), status: 303
        end
    end

    def destroy
        @review = Review.find(params[:id])
        if can?(:crud, @review)
            @review.destroy
            redirect_to idea_path(@idea)
            flash[:Notice] = "Review Deleted!"
        else
            flash[:Alert] = "Not Authorized!"
            redirect_to root_path
        end
    end

    private

    def find_idea
        @idea = Idea.find(params[:idea_id])
    end
end
