class PagesController < ApplicationController
  allow_unauthenticated_access

  def home
    @sections = LandingSection.active.ordered.includes(:section_cards)
  end

  def about
  end

  def consulting
  end
end
