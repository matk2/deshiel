class Pupils::EntriesController < ApplicationController
  def index
    @pupil_questions = current_user.pupil_questions
    @entry = current_user.entries.build
    @entry.entry_relationships.build
  end

  def create
    @entry = current_user.entries.build(params[:entry])

    if @entry.save
      redirect_to pupils_entries_path
    else
      render action: "index"
    end
  end
end