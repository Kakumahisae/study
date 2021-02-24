class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  # indexではBookに入っている本データをすべて取得し、
  # @booksにインスタンス化して代入することで、先のhtmlで全データを使えるようにしている
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  # showメソッドには何も書かれていないが、before_acitionにshowが指定されているので、
  # これが呼び出されるときはset_bookが実行されている。なおset_bookとはprivateに入っている（見てみ）
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  # createボタンを押すと、httpメソッドのpostを通じてここに来る。
  def create
    # ここで送られてきた情報であるbook_paramsに基づいて、@bookにインスタンス化する。
    # book_paramsの中身は以下privateに実装されている（見てみろ）
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        # @bookにredirectとは。@bookインスタンスで新規登録された図書idに基づいて、/books/:idのルートを作る。
        # もしid4だったのであれば、/books/4に飛ぶということ。
        # その後ろのnoticeなんちゃらは、リダイレクト先に渡すメッセージ。noticeeに"book was…"を代入し、
        # リダイレクトされたアクションによって出力されるビューに渡される。
        # リダイレクト先はget book/:idなので、showアクションが呼ばれる。
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #　(createアクションからなら）リダイレクトの結果受信したparamsを使用し、idの値に相当する図書を
    # DBの該当テーブルから取得する。
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # createアクションの続き↓↓↓　paramsは受信パラメーターオブジェクトという。
    # パラメーターとして受け取った入力情報は、paramsの中に格納されている。
    # params.require(:book)のbookはモデルbook。permitの中はカラム名。createアクションを通った時点では
    # book_paramとは何ぞとなるが、ここまでくるとその中身がわかる。（ストロングパラメータ）
    def book_params
      params.require(:book).permit(:title, :description)
    end
end
