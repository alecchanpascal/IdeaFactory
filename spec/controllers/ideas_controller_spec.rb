require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    describe "#new" do
        
        it "renders the new webpage" do
            get :new
            expect(response).to render_template(:new)
        end

        it "sets a new instance of an idea to a variable" do
            get :new
            expect(assigns(:idea)).to be_a_new(Idea)
        end
    end

    describe "#create" do
        context "with valid parameters" do
            def valid
                post :create, params: {idea: FactoryBot.attributes_for(:idea)}
            end

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
        end
    end
end
