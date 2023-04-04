class PagesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:dashboard]

  def home
  end

  def showroom
    @contact = Contact.new
  end

  def quines_somos
  end

  def talleres
    @talleres = Workshop.all
  end

  def eventos
    @events_upcoming = Event.where("date <= ?", Date.today).sort_by(&:date)
    @events_past = Event.where("date >= ?", Date.today).sort_by(&:date)
  end

  def tienda
  end

  def dashboard
  end
end
