class IdeasController < ApplicationController
    before_action :find_idea, only: [:show, :edit, :update, :destroy]

    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new(idea_params)
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

    private
    
    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def find_idea
        @idea = Idea.find(params[:id])
    end

end
