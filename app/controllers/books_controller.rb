class BooksController < ApplicationController
	before_action :set_book, only: [:show, :edit, :update, :destroy, :library]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@books = Book.all
	end

	def show
		
	end

	def edit
		@book = current_user.books.build
	end

	def create
		@book = current_user.books.build(book_params)
	end

	def destroy
		@book.destroy
	end

	# add books to library + remove books from libraru for current user
	def library
		type = params[:type]

		if type == 'add'
			current_user.library_additions << @book
			redirect_to library_index_path, notice: "#{@book.title} was added to your library"

		elsif type == 'remove'
			current_user.library_additions.delete(@book)
			redirect_to root_path, notice: "#{@book.title} was removed from your library"
		else
			# if the type is missing then do nothing  ¯\_(ツ)_/¯
			redirect_to book_path(@book), notice: 'Nothing happened 😬, try again!'
		end
	end

	private 

	def set_book
		@book = Book.find(params[:id])
	end

	def book_params
		params.require(:book).permit(:title, :description, :author, :thumbnail, :user_id)
	end
end