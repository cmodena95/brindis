class PagesController < ApplicationController
  def home
  end

  def showroom
  end

  def quines_somos
  end

  def talleres
    @talleres = Workshop.all
  end
end
