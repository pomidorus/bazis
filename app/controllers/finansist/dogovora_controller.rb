#encoding: utf-8

class Finansist::DogovoraController < ApplicationController
  def index

    @title = "Договора аренды"
    @dogovora = DogovorArenda.all

  end

  def show

    id = params[:id]
    @dogovor = DogovorArenda.find(id)
    @title = "Договор аренды земли №#{@dogovor.number}"

  end
end
