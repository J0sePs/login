class GalleriesController < ApplicationController
  # Requiere inicio de sesión para todas las acciones
  before_action :authenticate_user!

  # Permite solo a los administradores crear, editar y eliminar
  before_action :check_admin, only: %i[new create edit update destroy]

  # Busca la galería antes de mostrar, editar, actualizar o eliminar
  before_action :set_gallery, only: %i[show edit update destroy]

  # Acción para listar todas las galerías
  def index
    @galleries = Gallery.all.order(created_at: :desc)
  end

  # Acción para mostrar una galería específica
  def show; end

  # Acción para mostrar el formulario de nueva galería
  def new
    @gallery = Gallery.new
  end

  # Acción para crear una nueva galería
  def create
    @gallery = Gallery.new(gallery_params)

    if @gallery.save
      redirect_to @gallery, notice: 'Galería creada exitosamente.'
    else
      flash.now[:alert] = 'No se pudo crear la galería. Por favor revisa los errores.'
      render :new, status: :unprocessable_entity
    end
  end

  # Acción para mostrar el formulario de edición
  def edit; end

  # Acción para actualizar una galería
  def update
    if @gallery.update(gallery_params)
      redirect_to @gallery, notice: 'Galería actualizada exitosamente.'
    else
      flash.now[:alert] = 'No se pudo actualizar la galería. Por favor revisa los errores.'
      render :edit, status: :unprocessable_entity
    end
  end

  # Acción para eliminar una galería
  def destroy
    if @gallery.destroy
      redirect_to galleries_path, notice: 'Galería eliminada exitosamente.'
    else
      redirect_to galleries_path, alert: 'No se pudo eliminar la galería.'
    end
  end

  private

  # Método para buscar la galería
  def set_gallery
    @gallery = Gallery.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to galleries_path, alert: 'La galería no fue encontrada.'
  end

  # Permite solo los parámetros necesarios
  def gallery_params
    params.require(:gallery).permit(:title, :description, :media)
  end

  # Método para verificar si el usuario es administrador
  def check_admin
    unless current_user.admin?
      flash[:alert] = 'No tienes permisos para realizar esta acción.'
      redirect_to root_path
    end
  end
end
