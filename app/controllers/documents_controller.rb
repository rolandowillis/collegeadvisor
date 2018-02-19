
  class DocumentsController < ApplicationController
    before_action :set_document, only: [:show, :edit, :update, :destroy]


    # GET /documents
    def index
      @documents = Document.all
    end

    # GET /documents/1
    def show
      @document = Document.find(params[:id])

     content = @document.document.read

     if stale?(etag: content,  public: true)
       send_data content, type: @document.document.content_type, disposition: "inline"
       expires_in 0, public: true
     end
    end

    # GET /documents/new
    def new
      @document = Document.new
    end

    # GET /documents/1/edit
    def edit
    end

    # POST /documents
    def create
      @document = Document.new(document_params)
      if @document.save
        redirect_to documents_path, notice: 'Document was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /documents/1
    def update
      if @document.update(document_params)
        redirect_to @document, notice: 'Document was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /documents/1
    def destroy
      @document.destroy
      redirect_to documents_url, notice: 'Document was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_document
        @document = Document.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def document_params
         params.require(:document).permit(:document, :name)
      end
  end

