require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    def user
        @user ||= FactoryBot.create(:user)
    end

    describe "#new" do
        context "with signed in user" do
            before do 
                session[:user_id] = user.id
            end

            it "renders the new webpage" do
                get :new
                expect(response).to render_template(:new)
            end

            it "sets a new instance of an idea to a variable" do
                get :new
                expect(assigns(:idea)).to be_a_new(Idea)
            end
        end

        context "without signed in user" do
            it "redirects the user to sign in" do
                get(:new)
                expect(response).to redirect_to(new_session_path)
            end

            it "displays a flash message" do
                get(:new)
                expect(flash[:Alert]).to be
            end
        end
    end

    describe "#create" do
        def valid
            post :create, params: {idea: FactoryBot.attributes_for(:idea)}
        end

        context "without user signed in" do
            it "redirects to the user login page" do
                valid
                expect(response).to redirect_to(new_session_path)
            end
        end
        
        context "with user signed in" do
            before do
                session[:user_id] = user.id
            end

            context "with valid parameters" do
                it "creates a new idea in the database" do
                    before = Idea.count
                    valid
                    after = Idea.count
                    expect(after).to eq(before + 1)
                end

                it "redirects to the show page of the newly created idea" do
                    valid
                    expect(response).to redirect_to(idea_path(Idea.last))
                end
            end

            context "without valid parameters" do
                def invalid
                    post :create, params: {idea: {title: nil, description: nil}}
                end

                it "fails to add a new idea to the database" do
                    before = Idea.count
                    invalid
                    after = Idea.count
                    expect(before).to eq(after)
                end

                it "renders the new webpage again" do
                    invalid
                    expect(response).to render_template(:new)
                end

                it "adds invalid idea as an instance variable" do
                    invalid
                    expect(assigns(:idea)).to be_a(Idea)
                end
            end
        end
    end
end
