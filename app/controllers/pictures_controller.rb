class PicturesController < ApplicationController
  def recent
    @photos = Photo.all.order({ :created_at => :desc }).limit(25)

    render("pic_templates/time_list.html.erb")
  end

  def most_liked
    @photos = Photo.all.order({ :likes_count => :desc }).limit(25)

    render("pic_templates/liked_list.html.erb")
  end

  def show_details
    photo_id = params.fetch("some_id")

    @pic = Photo.where({ :id => photo_id }).at(0)

    render("pic_templates/details.html.erb")
  end
  
  def picture_form
    render("/pic_templates/pic_form.html.erb")
  end
  
  def create_photo_record
    p = Photo.new
    p.image = params.fetch("pic_image")
    p.caption = params.fetch("pic_caption")
    p.owner_id = params.fetch("poster_id")
    p.save
    redirect_to("/")
  end
  
  def photo_to_delete
    pic_id = params.fetch("id_to_delete")
    photo = Photo.where({:id => pic_id}).first
    photo.destroy
    redirect_to("/")
  end
  
  def photo_update_form
    pic_id = params.fetch("photo_id")
    @photo = Photo.where({:id => pic_id}).first
    render("pic_templates/pic_update_form.html.erb")
  end
  
  def photo_to_update
    pic_id = params.fetch("photo_id")
    photo = Photo.where({:id => pic_id}).first
    photo.image = params.fetch("pic_image")
    photo.caption = params.fetch("pic_caption")
    photo.save
    redirect_to("/photos/"+pic_id.to_s)
  end
  
end
