class LikesController < ApplicationController
    def create
        @idea = Idea.find(params[:idea_id])
        if !current_user
            flash[:Alert] = "You Must Be Signed In To Like An Idea!"
            redirect_back(fallback_location: root_path)
        else
            if @idea.user.id == current_user.id
                flash[:Alert] = "Cannot Like Your Own Idea!"
                redirect_back(fallback_location: root_path)
            else
                @like = Like.new(user: current_user, idea: @idea)
                if @like.save
                    flash[:Notice] = "Idea Liked!"
                else
                    flash[:Error] = @like.errors.full_messages.to_sentence
                end
                redirect_back(fallback_location: root_path)
            end
        end
    end

    def destroy
        @like = Like.find(params[:id])
        if @like.destroy
            flash[:Notice] = "Unliked!"
        else
            flash[:Error] = @like.errors.full_messages.to_sentence
        end
        redirect_back(fallback_location: root_path)
    end
end
