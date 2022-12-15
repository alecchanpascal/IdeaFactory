class IdeasController < ApplicationController
    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    before_action :authenticated_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new(idea_params)
        @idea.user = current_user
        if @idea.save
            flash[:Notice] = "Idea Added!"
            redirect_to idea_path(@idea)
        else
            flash[:Error] = @idea.errors.full_messages.to_sentence
            render :new
        end
    end

    def index
        @ideas = Idea.order(created_at: :desc)
    end 

    def show
        @reviews = @idea.reviews.order(created_at: :asc)
        @review = Review.new
        @like = @idea.likes.find_by(user: current_user)
    end

    def destroy
        @idea.destroy
        redirect_to ideas_path
        flash[:Notice] = "Idea Deleted!"
    end

    def edit
    end

    def update
        if @idea.update(idea_params)
            flash[:Notice] = "Idea Updated!"
            redirect_to idea_path(@idea)
        else 
            flash[:Error] = @idea.errors.full_messages.to_sentence
            render :edit
        end
    end

    def liked
        @ideas = current_user.liked_ideas
    end 

    private
    
    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def find_idea
        @idea = Idea.find(params[:id])
    end

    def authorize_user!
        unless can?(:crud, @idea)
            flash[:Alert] = "Not Authorized!"
            redirect_to root_path
        end
    end

end
