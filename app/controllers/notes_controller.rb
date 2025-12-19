class NotesController < ApplicationController
  def create
    summary = Notes::SummarizeService.new(note_params[:content]).call

    note = Note.new(note_params.merge(summary: summary))

    if note.save
      render json: note, status: :created
    else
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    notes = Note.order(created_at: :desc)
    render json: notes
  end

  def show
    note = Note.find(params[:id])
    render json: note
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Note not found" }, status: :not_found
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
